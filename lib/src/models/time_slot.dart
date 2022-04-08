enum TimeSlot {
  full,
  half,
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
