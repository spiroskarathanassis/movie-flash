import 'package:flutter/foundation.dart';

class Seat {
  // int id;
  bool isAvailable;
  bool isEnabled;

  Seat({
    // @required this.id,
    @required this.isAvailable,
    isEnabled = false
  });
}