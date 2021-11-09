import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_app/providers/movie_booked.dart';

class SubmitBook extends StatelessWidget {
  const SubmitBook({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final bookindData = Provider.of<MovieBooked>(context, listen: false);
    
    return Consumer<MovieBooked>(
      builder: (ctx, bookindData, _) => Container(
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bookindData.selectedMovie,
                      style: TextStyle(
                        fontSize: 24.0
                      ),
                    ),
                    Text(
                      '${bookindData.selectedDate.dayName} ${bookindData.selectedDate.dayNumber}',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16.0
                      ),
                    )
                  ]
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.white38,
                  ),
                  child: Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 12.0),
                        child: Text('Hall 1'),
                      ),
                      Row( 
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 12.0),
                            child: Icon(Icons.schedule_outlined),
                          ),
                          Text(
                            bookindData.selectedStartTime,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                )
              ]
            ),
            Container(
              margin: EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row( 
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 12.0),
                        child: Icon(
                          Icons.chair_outlined,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        'Seats',
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ]
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4.0),
                    child: Row(
                      children: bookindData.selectedSeats.map((seat) =>
                        Container(
                          margin: EdgeInsets.only(right: 4.0),
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: Colors.white38,
                          ),
                          child: Text(
                            seat,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5
                            ),
                          )
                        )
                      ).toList()
                    )
                  )
                ]
              )
            ,),
            new Container(
              margin: EdgeInsets.only(top: 16.0),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Checkbox(
                    value: bookindData.agreeTerms,
                    onChanged: (value) =>
                      bookindData.updateAgreeTerms(value)
                  ),
                  Flexible(
                    child: Text(
                      '*Doors close 5\' before. Please you have to check in on time.',
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    )
                  )
                ],
              )
            )
          ]
        )
      )
    );
  }
}