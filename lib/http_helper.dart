import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:movies/movie.dart';

class HttpHelper {
  final String apiKey = 'api_key=6e981ee4a733d7e26b0ec2fcd3535823';
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlUpcoming = '/upcoming?';
  final String urlLanguage = '&language=en-US';
  final String urlSearchBase =
      'https://api.themoviedb.org/3/search/movie?api_key=6e981ee4a733d7e26b0ec2fcd3535823&query=';

  Future<List?> getUpcoming() async {
    final String upcoming = urlBase + urlUpcoming + apiKey + urlLanguage;
    http.Response result = await http.get(Uri.parse(upcoming));
    print(result.statusCode);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = jsonDecode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      return null;
    }
  }

  Future<List?> findMovies(String title) async {
    String path = urlSearchBase + title;
    http.Response result = await http.get(Uri.parse(path));
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = jsonDecode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    }
    return null;
  }
}
