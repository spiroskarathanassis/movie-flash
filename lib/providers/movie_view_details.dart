// import 'dart:convert';
// import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';
import 'package:my_app/models/movie_date.dart';

class MovieViewDetails with ChangeNotifier {
  final List<MovieDate> _weekMovieDates = [
    MovieDate(dayName: "Mon", dayNumber: 22, dayHours: ['19:30', '21:00', '21:30']),
    MovieDate(dayName: "Tue", dayNumber: 23, dayHours: ['19:30', '21:00', '22:00']),
    MovieDate(dayName: "Wed", dayNumber: 24, dayHours: ['19:30', '21:30']),
    MovieDate(dayName: "Thu", dayNumber: 25, dayHours: ['19:30', '21:30']),
    MovieDate(dayName: "Fri", dayNumber: 26, dayHours: ['19:30', '21:00', '21:30']),
    MovieDate(dayName: "Sat", dayNumber: 27, dayHours: ['21:00']),
    MovieDate(dayName: "Sun", dayNumber: 28, dayHours: ['20:30', '21:00', '21:30'])
  ];
  List _seats = [];

  List<MovieDate> get weekMovieDates {
    return [..._weekMovieDates];
  }
  List<Map<String, Map<String, Map<String, dynamic>>>> get seats {
    return [..._seats];
  }

  MovieDate findDateByNumber(int dayNum) {
    return _weekMovieDates.firstWhere((el) => 
      el.dayNumber == dayNum
    );
  }

  Future<void> fetchHallSeats() async {
    // final String response = await rootBundle.loadString('assets/hall_seats.json');
    // print(response);
    // final currentSeats = jsonDecode(response) as List;
    await new Future.delayed(const Duration(milliseconds: 10));
    _seats = [
      {
        "A": {
          "1": {
            "id": null,
            "available": false,
            "enabled": false
          },
          "2": {
            "id": null,
            "available": true,
            "enabled": false
          },
          "3": {
            "id": null,
            "available": true,
            "enabled": false
          },
          "4": {
            "id": null,
            "available": true,
            "enabled": false
          },
          "5": {
            "id": null,
            "available": true,
            "enabled": false
          }
        }
      },
      {
        "B": {
          "1": {
            "id": null,
            "available": false,
            "enabled": false
          },
          "2": {
            "id": null,
            "available": true,
            "enabled": false
          },
          "3": {
            "id": null,
            "available": false,
            "enabled": false
          },
          "4": {
            "id": null,
            "available": true,
            "enabled": false
          },
          "5": {
            "id": null,
            "available": true,
            "enabled": false
          }
        }
      },
      {
        "C": {
          "1": {
            "id": null,
            "available": false,
            "enabled": false
          },
          "2": {
            "id": null,
            "available": true,
            "enabled": false
          },
          "3": {
            "id": null,
            "available": true,
            "enabled": false
          },
          "4": {
            "id": null,
            "available": true,
            "enabled": false
          },
          "5": {
            "id": null,
            "available": true,
            "enabled": false
          }
        }
      },
      {
        "D": {
          "1": {
            "id": null,
            "available": false,
            "enabled": false
          },
          "2": {
            "id": null,
            "available": true,
            "enabled": false
          },
          "3": {
            "id": null,
            "available": false,
            "enabled": false
          },
          "4": {
            "id": null,
            "available": true,
            "enabled": false
          },
          "5": {
            "id": null,
            "available": true,
            "enabled": false
          }
        }
      },
      {
        "E": {
          "1": {
            "id": null,
            "available": false,
            "enabled": false
          },
          "2": {
            "id": null,
            "available": true,
            "enabled": false
          },
          "3": {
            "id": null,
            "available": true,
            "enabled": false
          },
          "4": {
            "id": null,
            "available": true,
            "enabled": false
          },
          "5": {
            "id": null,
            "available": true,
            "enabled": false
          }
        }
      },
      {
        "F": {
          "1": {
            "id": null,
            "available": false,
            "enabled": false
          },
          "2": {
            "id": null,
            "available": true,
            "enabled": false
          },
          "3": {
            "id": null,
            "available": false,
            "enabled": false
          },
          "4": {
            "id": null,
            "available": true,
            "enabled": false
          },
          "5": {
            "id": null,
            "available": true,
            "enabled": false
          }
        }
      },
      {
        "G": {
          "1": {
            "id": null,
            "available": false,
            "enabled": false
          },
          "2": {
            "id": null,
            "available": true,
            "enabled": false
          },
          "3": {
            "id": null,
            "available": true,
            "enabled": false
          },
          "4": {
            "id": null,
            "available": true,
            "enabled": false
          },
          "5": {
            "id": null,
            "available": true,
            "enabled": false
          }
        }
      },
      {
        "H": {
          "1": {
            "id": null,
            "available": false,
            "enabled": false
          },
          "2": {
            "id": null,
            "available": true,
            "enabled": false
          },
          "3": {
            "id": null,
            "available": false,
            "enabled": false
          },
          "4": {
            "id": null,
            "available": true,
            "enabled": false
          },
          "5": {
            "id": null,
            "available": true,
            "enabled": false
          }
        }
      }
    ];
    
    notifyListeners();
  }
}