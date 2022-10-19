import 'package:flutter/material.dart';
import 'package:movies/movie.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;
  final String imgPath = 'https://image.tmdb.org/t/p/w500/';
  final String defultPath =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

  const MovieDetail({required this.movie});

  @override
  Widget build(BuildContext context) {
    String path = movie.posterPath == null
        ? defultPath
        : imgPath + movie.posterPath.toString();
    double imageHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(title: Text(movie.title!)),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(25),
                  height: imageHeight / 1.5,
                  child: Image.network(path),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(movie.overview!),
                )
              ],
            ),
          ),
        ));
  }
}
