import 'package:flutter/material.dart';
import 'package:my_app/providers/movie_booked.dart';
import 'package:my_app/view/movie_steps/book_date.dart';
import 'package:my_app/view/movie_steps/book_seats.dart';
import 'package:my_app/view/movie_steps/submit_book.dart';
import 'package:provider/provider.dart';

class MovieStepBooking extends StatefulWidget {
  const MovieStepBooking({ Key key }) : super(key: key);

  @override
  _MovieStepBookingState createState() => _MovieStepBookingState();
}

class _MovieStepBookingState extends State<MovieStepBooking> {
  int _stepIndex = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<MovieBooked>(context, listen: false).resetSelectedDate();
  }

  bool isCurrentStepCompleted(movieState) {
    /// Step 1
    if (_stepIndex == 0 && movieState.isDateFieldCompleted)
      return true;
    /// Step 2
    if (_stepIndex == 1 && movieState.selectedSeats.length > 0)
      return true;
    /// Step 3
    if (_stepIndex == 2 && movieState.agreeTerms)
      return true;
    
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final movieState = Provider.of<MovieBooked>(context);

    return new Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
      ),
      child: Container(
        // height: MediaQuery.of(context).size.height,
        height: 400.0,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20)
          )
        ),
        clipBehavior: Clip.hardEdge,
        child: new Stepper(
          type: StepperType.horizontal,
          physics: ScrollPhysics(),
          currentStep: _stepIndex,
          controlsBuilder: (ctx, {onStepContinue, onStepCancel}) {
            var continueText = 'CONTINUE';
            var cancelText = 'PREVIOUS';

            if (_stepIndex == 0)
              cancelText = 'EXIT';
            if (_stepIndex == 2)
              continueText = 'FINISH';
            
            final onStepContinue = (isCurrentStepCompleted(movieState))
              ? () async {
                  if (_stepIndex == 0) {
                    movieState.resetSelectedSeats();
                  }
                  if (_stepIndex == 2) {
                    await movieState.saveBooking();
                    Navigator.pushNamed(context, '/bookings');
                  }
                  if (_stepIndex < 2) {
                    setState(() { _stepIndex += 1; });
                  }
                }
              : null;

            final onStepCancel = () {
              if (_stepIndex == 0) {
                movieState.resetSelectedDate();
                movieState.resetSelectedTime();
                Navigator.pushNamed(context, '/movies');
              }
              else if (_stepIndex > 0) {
                setState(() { _stepIndex -= 1; });
              }
            };

            return Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Row(
                children: <Widget>[
                  TextButton(
                    onPressed: onStepContinue,
                    child: Text(
                      continueText,
                      style: TextStyle(
                        color: isCurrentStepCompleted(movieState) ? Colors.white : Colors.white30,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: onStepCancel,
                    child: Text(
                      cancelText,
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ],
              )
            );
          },
          // onStepTapped: (int index) {
          //   setState(() { _stepIndex = index; });
          // },
          steps: <Step>[
            Step(
              title: const Text('Date'),
              content: _stepIndex == 0 ? BookDate() : Text('Loading Movie Dates'),
              isActive: _stepIndex == 0
            ),
            Step(
              title: const Text('Seats'),
              content: _stepIndex == 1 ? BookSeats() : Text('Waiting for available seats'),
              isActive: _stepIndex == 1
            ),
            Step(
              title: const Text('Book'),
              content: _stepIndex == 2 ? SubmitBook() : Text('Refresh details'),
              isActive: _stepIndex == 2
            ),
          ],
        )
      )
    );
  }
}