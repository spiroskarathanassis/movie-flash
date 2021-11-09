import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_app/providers/movie_booked.dart';
import 'package:provider/provider.dart';

class Bookings extends StatelessWidget {
  // const Bookings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final booking = Provider.of<MovieBooked>(context, listen: false);
    const List<String> _randomNames = ['Joe Donne', 'Bil Bae', 'Jay Dibbre', 'John Pikey'];

    return Scaffold(
      appBar: AppBar(title: Text('Bookings'),),
      body: Container(
        child: ListView(
          children: [
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.movie_creation_outlined),
                    title: Text(booking.selectedMovie),
                    subtitle: Text('${booking.selectedDate.dayName} ${booking.selectedDate.dayNumber}  @${booking.selectedStartTime}'),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: ListView(
                      shrinkWrap: true,
                      children: booking.selectedSeats.map((seat) =>
                        Container(
                          margin: EdgeInsets.only(right: 4.0, top: 2.0),
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: Colors.blue[200]
                          ),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 4.0),
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: Colors.white
                                ),
                                child: Text(
                                  seat,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5
                                  ),
                                )
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Icon(Icons.person_outlined, size: 20.0,),
                                    ),
                                    Text(_randomNames[new Random().nextInt(_randomNames.length)])
                                  ],
                                )
                              ),
                            ],
                          )
                        )
                      ).toList()
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: const Text('CANCEL'),
                        onPressed: () {/* ... */},
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        child: const Text('CHECK IN'),
                        onPressed: () {/* ... */},
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            )
          ]
        )
      )
    );
  }
}