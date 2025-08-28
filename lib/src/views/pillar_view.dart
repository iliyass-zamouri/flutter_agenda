import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_agenda/flutter_agenda.dart';
import 'package:flutter_agenda/src/styles/background_painter.dart';
import 'package:flutter_agenda/src/utils/utils.dart';
import 'package:flutter_agenda/src/views/event_view.dart';

class PillarView extends StatefulWidget {
  final dynamic headObject;
  final List<AgendaEvent> events;
  final int lenght;
  final ScrollController scrollController;
  final AgendaStyle agendaStyle;
  final Function(EventTime, dynamic)? callBack;

  PillarView({
    Key? key,
    required this.headObject,
    required this.events,
    required this.lenght,
    required this.scrollController,
    required this.agendaStyle,
    this.callBack,
  }) : super(key: key);

  @override
  _PillarViewState createState() => _PillarViewState();
}

class _PillarViewState extends State<PillarView> {
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
    
    if (delta > 5.0) { // Threshold to detect actual scrolling
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
    return SingleChildScrollView(
      controller: widget.scrollController,
      physics: ClampingScrollPhysics(),
      child: GestureDetector(
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
              ? Utils.pillarWidth(widget.lenght, widget.agendaStyle.timeItemWidth,
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
                  lenght: widget.lenght,
                  agendaStyle: widget.agendaStyle,
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  EventTime tappedHour(double tapPosition, double itemHeight, int startHour) {
    double hourCount = (tapPosition / itemHeight);
    int hour = (startHour + hourCount.floor());
    int minute = hourCount - hourCount.floor() >= 0.5 ? 30 : 0;
    return EventTime(hour: hour, minute: minute);
  }

  double height() {
    return (widget.agendaStyle.endHour - widget.agendaStyle.startHour) *
        widget.agendaStyle.timeSlot.height;
  }
}
