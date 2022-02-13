import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_agenda/flutter_agenda.dart';
import 'package:flutter_agenda/src/models/pillar.dart';
import 'package:flutter_agenda/src/styles/agenda_style.dart';
import 'package:flutter_agenda/src/utils/utils.dart';
import 'package:flutter_agenda/src/extensions/expand_equally.dart';
import 'package:flutter_agenda/src/extensions/separator.dart';
import 'package:flutter_agenda/src/views/controller/agenda_view_controller.dart';
import 'package:flutter_agenda/src/views/diagonal_scroll_view.dart';
import 'package:flutter_agenda/src/views/pillar_view.dart';

class AgendaView extends StatefulWidget {
  final List<Pillar> pillarList;
  final Function(EventTime, dynamic)? onClick;
  final AgendaStyle agendaStyle;

  AgendaView({
    Key? key,
    required this.pillarList,
    this.onClick,
    this.agendaStyle: const AgendaStyle(),
  }) : super(key: key);

  @override
  _AgendaViewState createState() => _AgendaViewState();
}

class _AgendaViewState extends State<AgendaView> with AgendaViewController {
  @override
  void initState() {
    initController();
    super.initState();
  }

  @override
  void dispose() {
    disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildMainContent(context),
        _buildTimeLines(context),
        _buildPillars(context),
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
      child: DiagonalScrollView(
        horizontalPixelsStreamController: horizontalPixelsStream,
        verticalPixelsStreamController: verticalPixelsStream,
        onScroll: onScroll,
        maxWidth: widget.pillarList.length * widget.agendaStyle.pillarHeadWidth,
        maxHeight: (widget.agendaStyle.endHour - widget.agendaStyle.startHour) *
            widget.agendaStyle.timeItemHeight,
        child: IntrinsicHeight(
          child: Row(
            children: widget.pillarList.map((pillar) {
              return PillarView(
                headObject: pillar.head.object,
                events: pillar.events,
                callBack: (p0, p1) => widget.onClick!(p0, p1),
                agendaStyle: widget.agendaStyle,
              );
            }).toList(),
          ),
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
      child: ListView(
        physics: const ClampingScrollPhysics(),
        controller: verticalScrollController,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          for (var i = widget.agendaStyle.startHour;
              i < widget.agendaStyle.endHour;
              i += 1)
            i
        ].map((hour) {
          return Container(
            height: widget.agendaStyle.timeItemHeight,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: widget.agendaStyle.timelineBorderColor,
                  width: 0,
                ),
              ),
              color: widget.agendaStyle.timelineItemColor,
            ),
            child: widget.agendaStyle.timeItemHeight == 80
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                        child: Text(
                          Utils.hourFormatter(hour, 0),
                          style: widget.agendaStyle.timeItemTextStyle.copyWith(
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
                          style: widget.agendaStyle.timeItemTextStyle.copyWith(
                              color: widget.agendaStyle.timeItemTextColor),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ]
                        .expandEqually()
                        .seperate(widget.agendaStyle.timelineBorderColor)
                        .toList(),
                  )
                : widget.agendaStyle.timeItemHeight == 160
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
                                      color:
                                          widget.agendaStyle.timeItemTextColor,
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
                                      color:
                                          widget.agendaStyle.timeItemTextColor),
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
                                      color:
                                          widget.agendaStyle.timeItemTextColor),
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
                    : Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          Utils.hourFormatter(hour, 0),
                          style: widget.agendaStyle.timeItemTextStyle.copyWith(
                              color: widget.agendaStyle.timeItemTextColor,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.right,
                        ),
                      ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPillars(BuildContext context) {
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
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        controller: horizontalScrollController,
        shrinkWrap: true,
        children: widget.pillarList.map((pillar) {
          return GestureDetector(
            onTap: () => pillar.head.onTap,
            child: Container(
              width: pillar.head.width,
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
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
    );
  }
}
