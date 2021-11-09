import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/models/Movie.dart';

class Movies with ChangeNotifier{
  List<Movie> _movies = [];
  // final List<Movie> _movies = [
  //   Movie(title: "Time To Die", src: "assets/images/time_to_die.jpeg"),
  //   Movie(title: "Enternals", src: "assets/images/eternals.jpeg")
  // ];

  List<Movie> get movies => _movies;
  
  Future<void> fetchMovies() async {
    final url = Uri.parse(
      Uri.encodeFull(
        'https://flutter-movieflash-default-rtdb.firebaseio.com/current_movies.json'
      )
    );
    List<Movie> movies = [];

    try {
      final response = await http.get(url);
      // print(jsonDecode(response.body));
      final currentMovies = jsonDecode(response.body) as List;
      currentMovies.forEach((movie) {
        movies.add(Movie(
          title: movie['title'],
          src: movie['src'],
          description: movie['description']
        ));
      });

      _movies = movies;
      notifyListeners();
    } catch (e) {
      print(e);
      notifyListeners();
      // return _movies;
    }
  }
}