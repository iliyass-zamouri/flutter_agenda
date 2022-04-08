import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_agenda/flutter_agenda.dart';
import 'package:flutter_agenda/src/controllers/scroll_linker.dart';
import 'package:flutter_agenda/src/models/time_slot.dart';
import 'package:flutter_agenda/src/utils/scroll_config.dart';
import 'package:flutter_agenda/src/utils/utils.dart';
import 'package:flutter_agenda/src/extensions/expand_equally.dart';
import 'package:flutter_agenda/src/extensions/separator.dart';
import 'package:flutter_agenda/src/views/pillar_view.dart';

class FlutterAgenda extends StatefulWidget {
  /// Agenda visualization only one required parameter [pillarsList].
  FlutterAgenda({
    Key? key,
    required this.pillarList,
    this.onTap,
    this.agendaStyle: const AgendaStyle(),
  }) : super(key: key);

  /// list of pillar Object:
  ///
  /// [head] employee/resource.
  ///
  /// [events] (appointments/Todos) linked to the head.
  final List<Pillar> pillarList;

  /// longpress callback in an empty space in the calendar.
  ///
  /// gives the exact Clicked [eventTime].
  ///
  /// the dynamic object is the object you passed to the head object.
  /// it could be one of your won project custom resource object.
  final Function(EventTime, dynamic)? onTap;

  /// if you want to customize the view more
  final AgendaStyle agendaStyle;

  @override
  _FlutterAgendaState createState() => _FlutterAgendaState();
}

late ScrollLinker _horizontalScrollLinker;
late ScrollLinker _verticalScrollLinker;
List<ScrollController> _verticalScrollControllers = <ScrollController>[];
late ScrollController _headerScrollController;
late ScrollController _bodyScrollController;

class _FlutterAgendaState extends State<FlutterAgenda> {
  @override
  void initState() {
    super.initState();
    // init scroll linkers
    _verticalScrollLinker = ScrollLinker();
    _horizontalScrollLinker = ScrollLinker();

    // sychronize the scroll of the vertical scrollers
    _headerScrollController = _horizontalScrollLinker.addAndGet();
    _bodyScrollController = _horizontalScrollLinker.addAndGet();

    // sychronize the scroll of the horizontal scrollers
    _verticalScrollControllers.add(_verticalScrollLinker.addAndGet());
    for (var i = 0; i < widget.pillarList.length; i++) {
      _verticalScrollControllers.add(_verticalScrollLinker.addAndGet());
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (var i = 0; i < _verticalScrollControllers.length; i++) {
      _verticalScrollControllers[i].dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildMainContent(context),
        _buildTimeLines(context),
        _buildHeaders(context),
        _buildCorner(),
      ],
    );
  }

  Widget _buildCorner() {
    return Positioned(
      left: 0,
      top: 0,
      child: SizedBox(
        width: widget.agendaStyle.timeItemWidth + 1,
        height: widget.agendaStyle.pillarHeadHeight,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: widget.agendaStyle.cornerColor,
            border: Border(
                right: !widget.agendaStyle.cornerRight
                    ? BorderSide.none
                    : BorderSide(
                        color: widget.agendaStyle.timelineBorderColor,
                      ),
                bottom: !widget.agendaStyle.cornerBottom
                    ? BorderSide.none
                    : BorderSide(
                        color: widget.agendaStyle.timelineBorderColor,
                      )),
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: widget.agendaStyle.timeItemWidth,
        top: widget.agendaStyle.pillarHeadHeight,
      ),
      child: ScrollConfiguration(
        behavior: NoGlowScroll(),
        child: ListView(
          scrollDirection: Axis.horizontal,
          controller: _bodyScrollController,
          children: widget.pillarList.map((pillar) {
            return PillarView(
              headObject: pillar.head.object,
              scrollController: _verticalScrollControllers[
                  widget.pillarList.indexOf(pillar) + 1],
              events: pillar.events,
              callBack: (p0, p1) => widget.onTap!(p0, p1),
              agendaStyle: widget.agendaStyle,
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTimeLines(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: widget.agendaStyle.timeItemWidth + 1,
      padding: EdgeInsets.only(top: widget.agendaStyle.pillarHeadHeight),
      decoration: BoxDecoration(
        color: widget.agendaStyle.timelineColor,
        border: Border(
            right: BorderSide(color: widget.agendaStyle.timelineBorderColor)),
      ),
      child: ScrollConfiguration(
        behavior: NoGlowScroll(),
        child: ListView(
          controller: _verticalScrollControllers[0],
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            for (var i = widget.agendaStyle.startHour;
                i < widget.agendaStyle.endHour;
                i += 1)
              i
          ].map((hour) {
            return Container(
              height: widget.agendaStyle.timeSlot.height,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: widget.agendaStyle.timelineBorderColor,
                    width: 0,
                  ),
                ),
                color: widget.agendaStyle.timelineItemColor,
              ),
              child: widget.agendaStyle.timeSlot.height == 80
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                          child: Text(
                            Utils.hourFormatter(hour, 0),
                            style: widget.agendaStyle.timeItemTextStyle
                                .copyWith(
                                    color: widget.agendaStyle.timeItemTextColor,
                                    fontWeight: FontWeight.w400),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                          child: Text(
                            Utils.minFormatter(30),
                            style: widget.agendaStyle.timeItemTextStyle
                                .copyWith(
                                    color:
                                        widget.agendaStyle.timeItemTextColor),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ]
                          .expandEqually()
                          .seperate(widget.agendaStyle.timelineBorderColor)
                          .toList(),
                    )
                  : widget.agendaStyle.timeSlot.height == 160
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 5),
                              child: Text(
                                Utils.hourFormatter(hour, 0),
                                style: widget.agendaStyle.timeItemTextStyle
                                    .copyWith(
                                        color: widget
                                            .agendaStyle.timeItemTextColor,
                                        fontWeight: FontWeight.w400),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 5),
                              child: Text(
                                Utils.minFormatter(15),
                                style: widget.agendaStyle.timeItemTextStyle
                                    .copyWith(
                                        color: widget
                                            .agendaStyle.timeItemTextColor),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 5),
                              child: Text(
                                Utils.minFormatter(30),
                                style: widget.agendaStyle.timeItemTextStyle
                                    .copyWith(
                                        color: widget
                                            .agendaStyle.timeItemTextColor),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 5),
                              child: Text(
                                Utils.minFormatter(45),
                                style: widget.agendaStyle.timeItemTextStyle
                                    .copyWith(
                                        color: widget
                                            .agendaStyle.timeItemTextColor),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ]
                              .expandEqually()
                              .seperate(widget.agendaStyle.timelineBorderColor)
                              .toList(),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            Utils.hourFormatter(hour, 0),
                            style: widget.agendaStyle.timeItemTextStyle
                                .copyWith(
                                    color: widget.agendaStyle.timeItemTextColor,
                                    fontWeight: FontWeight.w400),
                            textAlign: TextAlign.right,
                          ),
                        ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildHeaders(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        color: widget.agendaStyle.pillarColor,
        border: !widget.agendaStyle.headBottomBorder
            ? null
            : Border(
                bottom:
                    BorderSide(color: widget.agendaStyle.timelineBorderColor)),
      ),
      height: widget.agendaStyle.pillarHeadHeight,
      padding: EdgeInsets.only(left: widget.agendaStyle.timeItemWidth),
      child: ScrollConfiguration(
        behavior: NoGlowScroll(),
        child: ListView(
          scrollDirection: Axis.horizontal,
          controller: _headerScrollController,
          shrinkWrap: true,
          children: widget.pillarList.map((pillar) {
            return GestureDetector(
              onTap: () => pillar.head.onTap,
              child: Container(
                width: widget.agendaStyle.pillarWidth,
                height: pillar.head.height,
                decoration: BoxDecoration(
                  color: pillar.head.backgroundColor,
                  border: !widget.agendaStyle.pillarSeperator
                      ? null
                      : Border(
                          left: BorderSide(
                              color: widget.agendaStyle.timelineBorderColor)),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: Material(
                          color: pillar.head.color.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(50),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 20.0,
                                sigmaY: 7.0,
                              ),
                              child: Container(
                                width: widget.agendaStyle.pillarHeadHeight - 10,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Text(
                                    pillar.head.title
                                        .substring(0, 1)
                                        .toUpperCase(),
                                    style: pillar.head.textStyle
                                        .copyWith(fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      pillar.head.subtitle != null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pillar.head.title,
                                  style: pillar.head.textStyle,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  pillar.head.subtitle ?? '',
                                  style: pillar.head.subtitleStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )
                          : Text(
                              pillar.head.title,
                              style: pillar.head.textStyle,
                              textAlign: TextAlign.center,
                            ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
