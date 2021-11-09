import 'package:flutter/material.dart';
import 'package:my_app/providers/movie_booked.dart';
import 'package:my_app/providers/movie_view_details.dart';
import 'package:provider/provider.dart';

class BookSeats extends StatefulWidget {
  // const BookSeats({ Key? key }) : super(key: key);
  
  @override
  _BookSeatsState createState() => _BookSeatsState();
}

class _BookSeatsState extends State<BookSeats> {
  // final List<Map<String, Map<String, Map<String, dynamic>>>> hallSeats = [
  //   {
  //     "A": {
  //       "1": { "id": null, "available": false, "enabled": false }, 
  //       "2": { "id": null, "available": true, "enabled": false },
  //       "3": { "id": null, "available": true, "enabled": false },
  //       "4": { "id": null, "available": true, "enabled": false },
  //       "5": { "id": null, "available": true, "enabled": false }
  //     },
  //   },
  // ];
  Future _hallSeatsFuture;
  List<Map<String, Map<String, Map<String, dynamic>>>> hallSeats = [];

  @override
  void initState() {
    _hallSeatsFuture = fetchMovieHallSeats();
    super.initState();
  }
  
  Future fetchMovieHallSeats() {
    return Provider.of<MovieViewDetails>(context, listen: false).fetchHallSeats();
  }
  
  int get sideSeatsLength => (hallSeats.length / 4).abs().toInt();
  int get mainSeatsLength => hallSeats.length - 2 * sideSeatsLength;
  
  Color seatBackgroundColor(dynamic seatValue) {
    if (seatValue["available"] == false) {
      return Colors.white10;
    }

    return (seatValue["enabled"] == false)
      ? Colors.blue.shade300 
      : Colors.white70;
  }

  void adjustSelectedSeats() {
    var alreadySelectedSeats = Provider.of<MovieBooked>(context, listen: false).selectedSeats;
    alreadySelectedSeats.forEach((seatEl) {
      var seatKV = seatEl.split('');
      var adjustSeat = hallSeats.firstWhere((el) => el.containsKey(seatKV[0]));
      adjustSeat[seatKV[0]][seatKV[1]]["enabled"] = true;
    });
  }

  void updateSeatAvailability(String changedSeatLetter, String changedSeatNumber, bool changedValue) {
    var adjustSeat = hallSeats.firstWhere((el) => el.containsKey(changedSeatLetter));
    setState(() {
      adjustSeat[changedSeatLetter][changedSeatNumber]["enabled"] = !changedValue;
      Provider.of<MovieBooked>(context, listen: false)
        .updateSelectedSeats('$changedSeatLetter$changedSeatNumber');
    });
  }

  List currentSideWidget(start, end) {
    var currentSideSeats = [];
    
    for (var i = start; i < end; i++) {
      var letterSeat = hallSeats[i];

      currentSideSeats.add(
        new Column(
          children: letterSeat.values.toList()[0].entries.toList()
            .map((numberSeat) {
              const double boxSize = 32.0;
              var seatValue = numberSeat.value;
              var seatChar = letterSeat.keys.toList()[0];
              // print(seatChar);
              // print(numberSeat.key);
              
              return SizedBox(
                width: boxSize,
                height: boxSize,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(seatBackgroundColor(seatValue)),
                    padding: MaterialStateProperty.all(EdgeInsets.all(0))
                  ),
                  onPressed: seatValue["available"]
                    ? () {
                        updateSeatAvailability(
                          seatChar, 
                          numberSeat.key, 
                          seatValue["enabled"]
                        );
                      }
                    : null,
                  child: Text('$seatChar${numberSeat.key}'),
                ),
              );
            }).toList()
        )
      );
    }

    return currentSideSeats.toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _hallSeatsFuture,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator()
          );
        } else {
          if (snapshot.error != null) {
            return Center(
              child: Text('No seats. An error occured'),
            );
          } else {
            return Consumer<MovieViewDetails>(
              builder: (consContext, moviedetails, _) {
                final seats = moviedetails.seats;
                hallSeats = seats;
                adjustSelectedSeats();
                
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[...currentSideWidget(0, sideSeatsLength)]
                        ),
                        Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[...currentSideWidget(sideSeatsLength, mainSeatsLength + sideSeatsLength)]
                        ),
                        Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[...currentSideWidget(mainSeatsLength + sideSeatsLength, mainSeatsLength + 2 * sideSeatsLength)]
                        ),
                      ],
                    )
                  ]
                );
              }
            );
          }
        }
      }
    );
  }
}