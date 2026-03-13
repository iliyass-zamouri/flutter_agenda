import 'package:flutter/material.dart';
import 'package:flutter_agenda/flutter_agenda.dart';
import 'package:flutter_agenda/src/controllers/scroll_linker.dart';
import 'package:flutter_agenda/src/controllers/agenda_state_controller.dart';
import 'package:flutter_agenda/src/utils/scroll_config.dart';
import 'package:flutter_agenda/src/utils/utils.dart';
import 'package:flutter_agenda/src/extensions/expand_equally.dart';
import 'package:flutter_agenda/src/extensions/separator.dart';
import 'package:flutter_agenda/src/views/optimized_pillar_view.dart';
import 'package:provider/provider.dart';


class FlutterAgenda extends StatefulWidget {
  /// Agenda visualization only one required parameter [pillarsList].
  FlutterAgenda({
    Key? key,
    required this.resources,
    this.onTap,
    this.agendaStyle = const AgendaStyle(),
  }) : super(key: key);

  /// list of pillar Object:
  ///
  /// [head] employee/resource.
  ///
  /// [events] (appointments/Todos) linked to the head.
  final List<Resource> resources;

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

class _FlutterAgendaState extends State<FlutterAgenda> {
  // scroll linkers
  late ScrollLinker _horizontalScrollLinker;
  late ScrollLinker _verticalScrollLinker;
  // vertical scroll controllers
  List<ScrollController> _verticalScrollControllers = <ScrollController>[];
  // horizontal (header, body) scroll controllers
  late ScrollController _headerScrollController;
  late ScrollController _bodyScrollController;
  
  // State controller for efficient updates
  late AgendaStateController _stateController;

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
    for (int i = 0; i < widget.resources.length; i++) {
      _verticalScrollControllers.add(_verticalScrollLinker.addAndGet());
    }
    
    // Initialize state controller
    _stateController = AgendaStateController(
      resources: widget.resources,
      agendaStyle: widget.agendaStyle,
    );
  }

  @override
  void dispose() {
    super.dispose();
    // disposing the vetical scrollers
    for (var i = 0; i < _verticalScrollControllers.length; i++) {
      _verticalScrollControllers[i].dispose();
    }
    // clearing the vertical scrollers list
    _verticalScrollControllers.clear();
    // disposing the horizontal scrollers
    _headerScrollController.dispose();
    _bodyScrollController.dispose();
    
    // Dispose state controller
    _stateController.dispose();
  }

  @override
  void didUpdateWidget(covariant FlutterAgenda oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Update scroll controllers if needed
    final neededCount = widget.resources.length + 1;
    final currentCount = _verticalScrollControllers.length;
    if (neededCount > currentCount) {
      for (int i = 0; i < neededCount - currentCount; i++) {
        _verticalScrollControllers.add(_verticalScrollLinker.addAndGet());
      }
    } else if (neededCount < currentCount) {
      for (int i = 0; i < currentCount - neededCount; i++) {
        final controller = _verticalScrollControllers.removeLast();
        controller.dispose();
      }
    }
    
    // Update state controller
    _stateController.updateResources(widget.resources);
    _stateController.updateAgendaStyle(widget.agendaStyle);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _stateController.clearChangeFlags();
    });
    return Directionality(
      textDirection: widget.agendaStyle.direction,
      child: ChangeNotifierProvider.value(
        value: _stateController,
        child: Stack(
          children: <Widget>[
            _buildMainContent(context),
            _buildTimeLines(context),
            if (widget.agendaStyle.headersPosition == HeadersPosition.bottom)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _buildHeaders(context),
              )
            else
              _buildHeaders(context),
            _buildCorner(),
          ],
        ),
      ),
    );
  }

  Widget _buildCorner() {
    return Positioned(
      left: widget.agendaStyle.direction == TextDirection.ltr ? 0 : null,
      right: widget.agendaStyle.direction == TextDirection.rtl ? 0 : null,
      top: widget.agendaStyle.headersPosition == HeadersPosition.bottom ? null : 0,
      bottom: widget.agendaStyle.headersPosition == HeadersPosition.bottom ? 0 : null,
      child: SizedBox(
        width: widget.agendaStyle.timeItemWidth + 1,
        height: widget.agendaStyle.headerHeight,
        child: DecoratedBox(
          position: DecorationPosition.background,
          decoration: BoxDecoration(
            color: widget.agendaStyle.cornerColor,
            border: Border(
                right: (!widget.agendaStyle.cornerRight &&
                        widget.agendaStyle.direction != TextDirection.rtl)
                    ? BorderSide.none
                    : BorderSide(
                        color: widget.agendaStyle.timelineBorderColor
                            .withOpacity(0.4),
                      ),
                left: (!widget.agendaStyle.cornerRight &&
                        widget.agendaStyle.direction != TextDirection.ltr)
                    ? BorderSide.none
                    : BorderSide(
                        color: widget.agendaStyle.timelineBorderColor
                            .withOpacity(0.4),
                      ),
                bottom: (!widget.agendaStyle.cornerBottom || widget.agendaStyle.headersPosition == HeadersPosition.bottom)
                    ? BorderSide.none
                    : BorderSide(
                        color: widget.agendaStyle.timelineBorderColor
                            .withOpacity(0.4),
                      ),
                top: (widget.agendaStyle.cornerBottom && widget.agendaStyle.headersPosition == HeadersPosition.bottom)
                    ? BorderSide(
                        color: widget.agendaStyle.timelineBorderColor
                            .withOpacity(0.4),
                      )
                    : BorderSide.none),
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: widget.agendaStyle.direction == TextDirection.ltr
            ? widget.agendaStyle.timeItemWidth
            : 0,
        right: widget.agendaStyle.direction == TextDirection.rtl
            ? widget.agendaStyle.timeItemWidth
            : 0,
        top: widget.agendaStyle.headersPosition == HeadersPosition.bottom ? 0 : widget.agendaStyle.headerHeight,
        bottom: widget.agendaStyle.headersPosition == HeadersPosition.bottom ? widget.agendaStyle.headerHeight : 0,
      ),
      child: ScrollConfiguration(
        behavior: NoGlowScroll(),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: ClampingScrollPhysics(),
          controller: _bodyScrollController,
          itemCount: widget.resources.length,
          itemBuilder: (context, index) {
            final pillar = widget.resources[index];
            return Selector<AgendaStateController, bool>(
              key: ValueKey('pillar_selector_$index'),
              selector: (_, ctrl) => ctrl.hasResourceChanged(index),
              shouldRebuild: (prev, next) => next,
              builder: (context, hasChanged, _) {
                return RepaintBoundary(
                  child: OptimizedPillarView(
                    headObject: pillar.head.object,
                    length: widget.resources.length,
                    scrollController: _verticalScrollControllers[index + 1],
                    events: pillar.events,
                    callBack: widget.onTap != null
                        ? (p0, p1) => widget.onTap!(p0, p1)
                        : null,
                    agendaStyle: widget.agendaStyle,
                    resourceIndex: index,
                    hasChanged: hasChanged,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildTimeLines(BuildContext context) {
    return Container(
      alignment: widget.agendaStyle.direction == TextDirection.rtl
          ? Alignment.topLeft
          : Alignment.topRight,
      width: widget.agendaStyle.timeItemWidth + 1,
      padding: EdgeInsets.only(
        top: widget.agendaStyle.headersPosition == HeadersPosition.bottom ? 0 : widget.agendaStyle.headerHeight,
        bottom: widget.agendaStyle.headersPosition == HeadersPosition.bottom ? widget.agendaStyle.headerHeight : 0,
      ),
      decoration: BoxDecoration(
        color: widget.agendaStyle.timelineColor,
        border: Border(
          right: widget.agendaStyle.direction == TextDirection.ltr
              ? BorderSide(
                  color:
                      widget.agendaStyle.timelineBorderColor.withOpacity(0.5))
              : BorderSide.none,
          left: widget.agendaStyle.direction == TextDirection.rtl
              ? BorderSide(
                  color:
                      widget.agendaStyle.timelineBorderColor.withOpacity(0.5))
              : BorderSide.none,
        ),
      ),
      child: ScrollConfiguration(
        behavior: NoGlowScroll(),
        child: RepaintBoundary(
          child: ListView.builder(
            key: ValueKey('timeline_list_${widget.agendaStyle.timeSlot.height}_${widget.agendaStyle.enableMultiDayEvents}'),
            controller: _verticalScrollControllers[0],
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: _timelineItemCount,
            itemBuilder: (context, index) => _buildTimelineItemAtIndex(index),
          ),
        ),
      ),
    );
  }

  int get _timelineItemCount {
    if (widget.agendaStyle.enableMultiDayEvents == true) {
      final startDate = widget.agendaStyle.timelineStartDate ?? DateTime.now();
      final endDate = widget.agendaStyle.timelineEndDate ?? startDate.add(const Duration(days: 1));
      final daysCount = endDate.difference(startDate).inDays + 1;
      final hoursPerDay = widget.agendaStyle.endHour - widget.agendaStyle.startHour;
      return daysCount * hoursPerDay + (daysCount - 1);
    } else {
      return widget.agendaStyle.endHour - widget.agendaStyle.startHour;
    }
  }

  Widget _buildTimelineItemAtIndex(int index) {
    if (widget.agendaStyle.enableMultiDayEvents == true) {
      final startDate = widget.agendaStyle.timelineStartDate ?? DateTime.now();
      final endDate = widget.agendaStyle.timelineEndDate ?? startDate.add(const Duration(days: 1));
      final daysCount = endDate.difference(startDate).inDays + 1;
      final hoursPerDay = widget.agendaStyle.endHour - widget.agendaStyle.startHour;
      int offset = index;
      for (int dayIndex = 0; dayIndex < daysCount; dayIndex++) {
        if (offset < hoursPerDay) {
          final hour = widget.agendaStyle.startHour + offset;
          return _buildTimelineHourItem(hour);
        }
        offset -= hoursPerDay;
        if (dayIndex < daysCount - 1) {
          if (offset == 0) {
            final currentDate = DateTime(startDate.year, startDate.month, startDate.day)
                .add(Duration(days: dayIndex + 1));
            return Container(
              key: ValueKey('timeline_sep_${currentDate.day}'),
              height: widget.agendaStyle.daySeparatorHeight ?? 40.0,
              decoration: BoxDecoration(
                color: widget.agendaStyle.daySeparatorColor ?? Colors.grey[200],
                border: Border(
                  top: BorderSide(
                    color: widget.agendaStyle.daySeparatorBorderColor ?? Colors.grey[400]!,
                    width: 2.0,
                  ),
                  bottom: BorderSide(
                    color: widget.agendaStyle.daySeparatorBorderColor ?? Colors.grey[400]!,
                    width: 1.0,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  '${_getDayName(currentDate.weekday)}\n${currentDate.day.toString().padLeft(2, '0')}/${currentDate.month.toString().padLeft(2, '0')}',
                  style: widget.agendaStyle.daySeparatorTextStyle ?? const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            );
          }
          offset -= 1;
        }
      }
      return const SizedBox.shrink();
    } else {
      final hour = widget.agendaStyle.startHour + index;
      return _buildTimelineHourItem(hour);
    }
  }

  Widget _buildTimelineHourItem(int hour) {
    return Container(
      key: ValueKey('timeline_${hour}_${widget.agendaStyle.timeSlot.height}'),
      height: widget.agendaStyle.timeSlot.height,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: widget.agendaStyle.timelineBorderColor.withOpacity(0.8),
            width: 0.8,
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
                                    fontWeight: FontWeight.w500),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                          child: Text(
                            Utils.hourFormatter(hour, 30),
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
                                Utils.hourFormatter(hour, 30),
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
                      : Container(
                          alignment: Alignment.center,
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
  }

  String _getDayName(int weekday) {
    const days = ['Mon.', 'Tue.', 'Wed.', 'Thu.', 'Fri.', 'Sat.', 'Sun.'];
    return days[weekday - 1];
  }

  Widget _buildHeaders(BuildContext context) {
    return Container(
      alignment: widget.agendaStyle.direction == TextDirection.rtl
          ? Alignment.topLeft
          : Alignment.topRight,
      decoration: BoxDecoration(
        color: widget.agendaStyle.pillarColor,
        border: !widget.agendaStyle.headBottomBorder
            ? null
            : (widget.agendaStyle.headersPosition == HeadersPosition.bottom
                ? Border(
                    top: BorderSide(
                        color: widget.agendaStyle.timelineBorderColor
                            .withOpacity(0.4)))
                : Border(
                    bottom: BorderSide(
                        color: widget.agendaStyle.timelineBorderColor
                            .withOpacity(0.4)))),
      ),
      height: widget.agendaStyle.headerHeight,
      padding: EdgeInsets.only(
          left: widget.agendaStyle.direction == TextDirection.ltr
              ? widget.agendaStyle.timeItemWidth
              : 0,
          right: widget.agendaStyle.direction == TextDirection.rtl
              ? widget.agendaStyle.timeItemWidth
              : 0),
      child: ScrollConfiguration(
        behavior: NoGlowScroll(),
        child: RepaintBoundary(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: ClampingScrollPhysics(),
            controller: _headerScrollController,
            shrinkWrap: true,
            itemCount: widget.resources.length,
            itemBuilder: (context, index) {
              final pillar = widget.resources[index];
              return GestureDetector(
              onTap: () => pillar.head.onTap,
              child: Container(
                width: widget.agendaStyle.fittedWidth
                    ? Utils.pillarWidth(
                        widget.resources.length,
                        widget.agendaStyle.timeItemWidth,
                        widget.agendaStyle.pillarWidth,
                        MediaQuery.of(context).orientation)
                    : widget.agendaStyle.pillarWidth,
                height: pillar.head.height,
                decoration: BoxDecoration(
                  color: pillar.head.backgroundColor,
                  border: !widget.agendaStyle.headSeperator
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
                        child: widget.agendaStyle.headerLogo ==
                                HeaderLogo.circle
                            ? Container(
                                width: widget.agendaStyle.headerHeight - 10,
                                decoration: BoxDecoration(
                                  color: pillar.head.color.withOpacity(0.5),
                                  shape: BoxShape.circle,
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
                              )
                            : Container(
                                width: 5,
                                height: widget.agendaStyle.headerHeight,
                                decoration: BoxDecoration(
                                  color: pillar.head.color,
                                  borderRadius: BorderRadius.circular(50),
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
            },
          ),
        ),
      ),
    );
  }
}
