class TimeSlot {
  final int hour;

  const TimeSlot(this.hour);

  String get display => '$hour:00';

  static const available = [
    TimeSlot(9),
    TimeSlot(10),
    TimeSlot(11),
    TimeSlot(13),
    TimeSlot(14),
    TimeSlot(15),
    TimeSlot(16),
  ];
}
