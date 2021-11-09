import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_app/providers/movie_booked.dart';
import 'package:my_app/providers/movie_view_details.dart';

class BookDate extends StatefulWidget {
  const BookDate({ Key key }) : super(key: key);

  @override
  _BookDateState createState() => _BookDateState();
}

class _BookDateState extends State<BookDate> {
  final Color _unselectedColor = Colors.white24;
  final Color _unselectedTextColor = Colors.black54;
  final Color _disabledColor = Colors.blue.shade600;
  final Color _selectedColor = Colors.white;
  final Color _selectedTextColor = Colors.blue.shade600;

  // dummy disabled
  bool disabledTimeSlot(String slotTime) => slotTime == '21:30';

  @override
  Widget build(BuildContext context) {
    final weekMovieDates = Provider.of<MovieViewDetails>(context).weekMovieDates;
    final foundedDateByNum = Provider.of<MovieViewDetails>(context, listen: false).findDateByNumber;

    final movieState = Provider.of<MovieBooked>(context);

    return Consumer<MovieViewDetails>(
      builder: (ctx, dates, _) =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Day'),
                Container(
                  margin: EdgeInsets.only(top: 12),
                  height: 80,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: weekMovieDates.map<Widget>((currDate) =>
                      SizedBox(
                        width: 60,
                        height: 100,
                        child: ChoiceChip(
                          padding: EdgeInsets.all(4),
                          side: BorderSide(color: _unselectedColor),
                          backgroundColor: Colors.blue,
                          selectedColor: _selectedColor,
                          onSelected: (bool _) {
                            var selected = foundedDateByNum(currDate.dayNumber);
                            movieState.updateSelectedDate(selected);
                          },
                          selected: movieState.isCurrentDate(currDate.dayNumber),
                          label:  Flex(
                            direction: Axis.vertical, 
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                currDate.dayNumber.toString(),
                                style: TextStyle(
                                  fontSize: 24,
                                  color: movieState.isCurrentDate(currDate.dayNumber) ? _selectedTextColor : _unselectedTextColor
                                )
                              ),
                              Text(
                                currDate.dayName,
                                style: TextStyle(
                                  color: movieState.isCurrentDate(currDate.dayNumber) ? _selectedTextColor : _unselectedTextColor
                                )
                              )
                            ],
                          ),
                        ),
                      )
                    ).toList()
                  )
                ),
              
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hours'),
                  (movieState.selectedDate != null)
                    ? Wrap(
                        direction: Axis.horizontal,
                        children: movieState.selectedDate.dayHours.map((slotTime) {
                          return Padding(
                            padding: EdgeInsets.all(4),
                            child: ChoiceChip(
                              side: BorderSide(color: !disabledTimeSlot(slotTime) ? _unselectedColor : _disabledColor),
                              backgroundColor: Colors.blue,
                              disabledColor: _disabledColor,
                              selectedColor: _selectedColor,
                              label: Text(slotTime),
                              selected: movieState.selectedStartTime == slotTime,
                              onSelected: !disabledTimeSlot(slotTime)
                                ? (bool _) { movieState.updateSelectedTime(slotTime); }
                                : null
                            )
                          );
                        }).toList(),
                      )
                    : Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          'Select a day to see available time slots.',
                          style: TextStyle(color: Colors.black.withOpacity(0.35)),
                        )
                      )
                ],
              )
            )
          ],
        ),
    );
  }
}