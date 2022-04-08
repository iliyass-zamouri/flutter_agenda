enum TimeSlot {
  /// full time slot is 1h time slot
  full,

  /// half time slot is 30min time slot
  half,

  /// quarter time slot is 15min time slot
  quarter,
}

extension TimeSlotExtension on TimeSlot {
  double get height {
    switch (this) {
      case TimeSlot.full:
        return 60;
      case TimeSlot.half:
        return 80;
      case TimeSlot.quarter:
        return 160;
    }
  }
}
