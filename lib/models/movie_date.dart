import 'package:flutter/foundation.dart';

class MovieDate {
  final String dayName;
  final int dayNumber;
  final List<String> dayHours;

  MovieDate({
    @required this.dayName,
    @required this.dayNumber,
    @required this.dayHours
  });
}