import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_app/providers/movie_booked.dart';
import 'package:my_app/providers/movies.dart';
import 'package:my_app/view/modals/movie_step_booking.dart';
import 'package:provider/provider.dart';

class MoviesPreview extends StatefulWidget {
  const MoviesPreview({ Key key }) : super(key: key);

  @override
  _MoviesPreviewState createState() => _MoviesPreviewState();
}

class _MoviesPreviewState extends State<MoviesPreview> {
  final double _imageContainerHeight = 200.0;
  int movieIndex = 0;
  int moviesLength = 0;
  bool isBooking = false;

  void toggleBooking(title) {
    setState(() => isBooking = !isBooking);
    Provider.of<MovieBooked>(context, listen: false).updateSelectedMovie(title);
  }

  bool isImageSideEnabled(String dir) {
    var isLeftSideLimit = dir == 'left' && movieIndex == 0;
    var isRightSideLimit = dir == 'right' && movieIndex == moviesLength - 1;

    return !(isLeftSideLimit || isRightSideLimit);
  }

  Widget slideButton(String direction) {
    var icon = direction == 'left'
      ? Icons.keyboard_arrow_left
      : Icons.keyboard_arrow_right;

    return Container(
      height: double.infinity,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white12),
        ),
        child: Icon(
          icon,
          size: 24.0
        ),
        onPressed: isImageSideEnabled(direction)
        ? () {
            setState(() { 
              (direction == 'left') ? movieIndex -= 1 : movieIndex += 1;
            });
          }
        : null
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final moviesState = Provider.of<Movies>(context).movies;
    moviesLength = moviesState.length;
    
    return Scaffold(
      appBar: AppBar(title: Text(moviesLength > 0 ? moviesState[movieIndex].title : ''),),
      body: new Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: _imageContainerHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(moviesState[movieIndex].src),
                    fit: BoxFit.fitWidth,
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    slideButton('left'),
                    ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 4.0,
                          sigmaY: 4.0
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 2.0,
                            horizontal: 12.0
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: Colors.white24
                          ),
                          child: TextButton(
                            onPressed: () => toggleBooking(moviesState[movieIndex].title),
                            child: Text('Book')
                          ),
                        )
                      ),
                    ),
                    slideButton('right'),
                  ]
                )
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star_rate_rounded, size: 20.0, color: Colors.blue),
                            Icon(Icons.star_rate_rounded, size: 20.0, color: Colors.blue),
                            Icon(Icons.star_rate_rounded, size: 20.0, color: Colors.blue),
                            Icon(Icons.star_rate_rounded, size: 20.0, color: Colors.blue),
                            Icon(Icons.star_border_rounded, size: 20.0, color: Colors.blue),
                          ],
                        )
                      ]
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12.0),
                      child: Text(
                        moviesState[movieIndex].description,
                        style: TextStyle(
                          fontSize: 16.0
                        ),
                      ),
                    )
                  ],
                )
              ),
            ]
          ),
          if (isBooking)
            Align(
              alignment: Alignment.bottomCenter,
              child: MovieStepBooking()
            )
        ],
      )
    );
  }
}