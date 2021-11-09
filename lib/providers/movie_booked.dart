import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import 'package:my_app/models/movie_date.dart';

class MovieBooked with ChangeNotifier {
  String _selectedMovie = '';
  MovieDate _selectedDate;
  String _selectedStartTime = '';
  List<String> _selectedSeats = [];
  bool _agreeTerms = false;

  String get selectedMovie => _selectedMovie;
  MovieDate get selectedDate => _selectedDate;
  String get selectedStartTime => _selectedStartTime;
  List<String> get selectedSeats => [..._selectedSeats];
  bool get agreeTerms => _agreeTerms;

  void updateSelectedMovie(String movie) {
    _selectedMovie = movie;
    notifyListeners();
  }
  void updateSelectedDate(MovieDate newDate) {
    _selectedDate = newDate;
    this.resetSelectedTime();
    this.updateAgreeTerms(false);
    // notifyListeners();
  }
  void updateSelectedTime(String newTime) {
    _selectedStartTime = newTime;
    notifyListeners();
  }
  void updateSelectedSeats(String seat) {
    var isSeatexist = _selectedSeats.contains(seat);

    if (isSeatexist == true)
      _selectedSeats.remove(seat);
    else
      _selectedSeats.add(seat);

    notifyListeners();
  }
  void updateAgreeTerms(bool value) {
    _agreeTerms = value;
    notifyListeners();
  }

  // reset
  void resetSelectedDate() {
    _selectedDate = null;
    notifyListeners();
  }
  void resetSelectedTime() {
    _selectedStartTime = '';
    notifyListeners();
  }
  void resetSelectedSeats() {
    _selectedSeats = [];
    notifyListeners();
  }


  bool get isDateFieldCompleted => 
    _selectedDate != null && _selectedStartTime.isNotEmpty;

  bool isCurrentDate(int currDate) => 
    _selectedDate != null && _selectedDate.dayNumber == currDate;

  Future<void> saveBooking() async {
    final url = Uri.parse(
      Uri.encodeFull(
        "https://flutter-movieflash-default-rtdb.firebaseio.com/bookings.json"
      )
    );

    try {
      await http
        .post(
          url,
          body: jsonEncode({
            'user': 'Peter',
            'movie': selectedMovie,
            'date': selectedDate.dayName,
            'time': selectedStartTime
          })
        );
    } catch (e) {
        print(e);
    }
    
  }
}