import 'package:flutter/material.dart';
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
  final AgendaStyle agendaStyle;

  AgendaView({
    Key? key,
    required this.pillarList,
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
        height: widget.agendaStyle.pillarHeight,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: widget.agendaStyle.cornerColor,
            border: Border(
                right: BorderSide(
                  color: widget.agendaStyle.timelineBorderColor,
                ),
                bottom: BorderSide(
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
        top: widget.agendaStyle.pillarHeight,
      ),
      child: DiagonalScrollView(
        horizontalPixelsStreamController: horizontalPixelsStream,
        verticalPixelsStreamController: verticalPixelsStream,
        onScroll: onScroll,
        maxWidth: widget.pillarList.length * widget.agendaStyle.pillarWidth,
        maxHeight: (widget.agendaStyle.endHour - widget.agendaStyle.startHour) *
            widget.agendaStyle.timeItemHeight,
        child: IntrinsicHeight(
          child: Row(
            children: widget.pillarList.map((pillar) {
              return PillarView(
                events: pillar.events,
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
      padding: EdgeInsets.only(top: widget.agendaStyle.pillarHeight),
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
                          style: TextStyle(
                              color: widget.agendaStyle.timeItemTextColor,
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                        child: Text(
                          Utils.hourFormatter(hour, 30),
                          style: TextStyle(
                              color: widget.agendaStyle.timeItemTextColor,
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ]
                        .expandEqually()
                        .seperate(widget.agendaStyle.timelineBorderColor)
                        .toList(),
                  )
                : Text(
                    Utils.hourFormatter(hour, 0),
                    style: TextStyle(
                        color: widget.agendaStyle.timeItemTextColor,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.right,
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
        border: Border(
            bottom: BorderSide(color: widget.agendaStyle.timelineBorderColor)),
      ),
      height: widget.agendaStyle.pillarHeight,
      padding: EdgeInsets.only(left: widget.agendaStyle.timeItemWidth),
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        controller: horizontalScrollController,
        shrinkWrap: true,
        children: widget.pillarList.map((pillar) {
          return Container(
            width: pillar.head.width,
            height: pillar.head.height,
            decoration: BoxDecoration(
              color: pillar.head.backgroundColor,
              border: Border(
                  left: BorderSide(
                      color: widget.agendaStyle.timelineBorderColor)),
            ),
            child: Center(
              child: Text(
                pillar.head.name,
                style: pillar.head.textStyle
                    .copyWith(color: pillar.head.textColor),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
