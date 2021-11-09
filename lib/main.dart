import 'dart:ui';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'view/pages/bookings.dart';
import 'view/pages/home_screen.dart';
import 'package:my_app/providers/movies.dart';
import 'providers/movie_view_details.dart';
import './providers/movie_booked.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Movies()),
        ChangeNotifierProvider(create: (_) => MovieViewDetails()),
        ChangeNotifierProvider(create: (_) => MovieBooked())
      ],
      child: MaterialApp(
        title: 'Quiz',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme: ThemeData(primarySwatch: Colors.blue).colorScheme.copyWith(secondary: Colors.amber),
          canvasColor: Color.fromRGBO(225, 254, 229, 1),
          // fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
            // bodyText1: TextStyle(Color.fromRGBO(20, 51, 51, 1)),
            headline6: TextStyle(
              fontSize: 20,
              // fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold
            )
          ),
        ),
        home: HomeScreen(),
        routes: {
          '/movies': (context) => HomeScreen(),
          '/bookings': (context) => Bookings(),
        },
      ),
    );
  }
}

