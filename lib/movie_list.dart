import 'package:flutter/material.dart';
import 'package:movies/http_helper.dart';
import 'package:movies/movie_detail.dart';

class MovieList extends StatefulWidget {
  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final String defaultImage =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  String result = 'null';
  late HttpHelper helper;
  int? moviesCount;
  late List movies;
  Icon visibleIcon = Icon(Icons.search);
  Widget searchBar = Text('Movies');

  Future intialize() async {
    movies = [];
    movies = (await helper.getUpcoming())!;
    moviesCount = movies.length;
    setState(() {});
  }

  Future search(text) async {
    movies = [];
    movies = (await helper.findMovies(text))!;
    moviesCount = movies.length;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    helper = HttpHelper();
    intialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;
    String imageUrl;
    return Scaffold(
      appBar: AppBar(
        title: searchBar,
        actions: [
          IconButton(
            icon: visibleIcon,
            onPressed: () {
              setState(() {
                if (visibleIcon.icon == Icons.search) {
                  visibleIcon = const Icon(Icons.cancel);
                  searchBar = TextField(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (text) {
                      search(text);
                    },
                  );
                } else {
                  setState(() {
                    this.visibleIcon = Icon(Icons.search);
                    this.searchBar = Text('Movies');
                  });
                }
              });
            },
          )
        ],
      ),
      body: ListView.builder(
          itemCount: moviesCount ?? 0,
          itemBuilder: (BuildContext context, int position) {
            imageUrl = movies[position].posterPath != null
                ? iconBase + movies[position].posterPath
                : defaultImage;
            image = NetworkImage(imageUrl);
            return Card(
              color: Colors.white,
              elevation: 2.0,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              MovieDetail(movie: movies[position])));
                },
                title: Text(movies[position].title),
                subtitle: Text(
                    '${'Released: ' + movies[position].releaseDate} - Vote: ${movies[position].voteAverage}'),
                leading: CircleAvatar(
                  backgroundImage: image,
                ),
              ),
            );
          }),
    );
  }
}
