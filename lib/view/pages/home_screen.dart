import 'package:flutter/material.dart';
import 'package:my_app/providers/movies.dart';
import 'package:my_app/view/pages/movies_preview.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Movies>(context, listen: false).fetchMovies(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator()
          );
        } else {
          if (snapshot.error != null) {
            return Center(
              child: Text('An error occured'),
            );
          } else {
            return Consumer<Movies>(
              builder: (ctx, data, _) {
                final totalMovies = data.movies.length;

                if (totalMovies > 0) {
                  return MoviesPreview();
                } else {
                  return Center(
                    child: Text('We are closed this week :)')
                  );
                }
              }
            );
          }
        }
      }
    );
  }
}
