import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_agenda/flutter_agenda.dart';
import 'package:flutter_agenda/src/styles/background_painter.dart';
import 'package:flutter_agenda/src/utils/utils.dart';
import 'package:flutter_agenda/src/views/event_view.dart';

class OptimizedPillarView extends StatelessWidget {
  final dynamic headObject;
  final List<AgendaEvent> events;
  final int length;
  final ScrollController scrollController;
  final AgendaStyle agendaStyle;
  final Function(EventTime, dynamic)? callBack;
  final int resourceIndex;
  final bool hasChanged;

  const OptimizedPillarView({
    Key? key,
    required this.headObject,
    required this.events,
    required this.length,
    required this.scrollController,
    required this.agendaStyle,
    this.callBack,
    required this.resourceIndex,
    required this.hasChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Only rebuild if this specific pillar has changed
    if (!hasChanged) {
      return _buildPillarContent();
    }
    
    return _buildPillarContent();
  }

  Widget _buildPillarContent() {
    return SingleChildScrollView(
      controller: scrollController,
      physics: ClampingScrollPhysics(),
              child: _PillarContent(
          headObject: headObject,
          events: events,
          length: length,
          agendaStyle: agendaStyle,
          callBack: callBack,
          resourceIndex: resourceIndex,
          scrollController: scrollController,
        ),
    );
  }
}

class _PillarContent extends StatefulWidget {
  final dynamic headObject;
  final List<AgendaEvent> events;
  final int length;
  final AgendaStyle agendaStyle;
  final Function(EventTime, dynamic)? callBack;
  final int resourceIndex;
  final ScrollController scrollController;

  const _PillarContent({
    Key? key,
    required this.headObject,
    required this.events,
    required this.length,
    required this.agendaStyle,
    this.callBack,
    required this.resourceIndex,
    required this.scrollController,
  }) : super(key: key);

  @override
  _PillarContentState createState() => _PillarContentState();
}

class _PillarContentState extends State<_PillarContent> {
  bool _isScrolling = false;
  Timer? _scrollEndTimer;
  bool _hasScrolled = false;
  double _lastScrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollEndTimer?.cancel();
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final currentPosition = widget.scrollController.position.pixels;
    final delta = (currentPosition - _lastScrollPosition).abs();
    
    if (delta > 5.0) {
      _hasScrolled = true;
      if (!_isScrolling) {
        setState(() {
          _isScrolling = true;
        });
      }
    }
    
    _lastScrollPosition = currentPosition;
    
    _scrollEndTimer?.cancel();
    _scrollEndTimer = Timer(Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _isScrolling = false;
          _hasScrolled = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        if (!_hasScrolled && widget.callBack != null) {
          widget.callBack!(
              tappedHour(details.localPosition.dy, widget.agendaStyle.timeSlot.height,
                  widget.agendaStyle.startHour),
              widget.headObject);
        }
      },
      onPanStart: (DragStartDetails details) {
        _hasScrolled = true;
      },
      onPanUpdate: (DragUpdateDetails details) {
        _hasScrolled = true;
      },
      child: Container(
        height: height(),
        width: widget.agendaStyle.fittedWidth
            ? Utils.pillarWidth(widget.length, widget.agendaStyle.timeItemWidth,
                widget.agendaStyle.pillarWidth, MediaQuery.of(context).orientation)
            : widget.agendaStyle.pillarWidth,
        decoration: widget.agendaStyle.pillarSeperator
            ? BoxDecoration(
                border: Border(left: BorderSide(color: Color(0xFFCECECE))))
            : BoxDecoration(),
        child: Stack(
          children: [
            ...[
              Positioned.fill(
                child: CustomPaint(
                  painter: BackgroundPainter(
                    agendaStyle: widget.agendaStyle,
                  ),
                ),
              )
            ],
            ...widget.events.map((event) {
              return EventView(
                event: event,
                lenght: widget.length,
                agendaStyle: widget.agendaStyle,
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  EventTime tappedHour(double tapPosition, double itemHeight, int startHour) {
    double hourCount = (tapPosition / itemHeight);
    int hour = (startHour + hourCount.floor());
    int minute = hourCount - hourCount.floor() >= 0.5 ? 30 : 0;
    return SingleDayEventTime(hour: hour, minute: minute);
  }

  double height() {
    return (widget.agendaStyle.endHour - widget.agendaStyle.startHour) *
        widget.agendaStyle.timeSlot.height;
  }
}
