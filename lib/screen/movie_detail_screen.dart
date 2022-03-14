import 'package:flutter/material.dart';
import 'package:movie_ui_demo/model/movie_model.dart';
import 'package:movie_ui_demo/screen/home_screen.dart';

class MovieDetailScreen extends StatelessWidget {
  final Results? movies;
  const MovieDetailScreen({Key? key, this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Hero(
            tag: movies!.id.toString(),
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Container(
                  foregroundDecoration: BoxDecoration(
                    gradient: LinearGradient(
                        end: Alignment.topCenter,
                        begin: Alignment.bottomCenter,
                        colors: [
                          Colors.black,
                          Colors.black38.withOpacity(0),
                        ]),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          alignment: Alignment.topCenter,
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              BASE_IMAGE_URL + movies!.posterPath!))),
                )),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Material(
                color: Colors.black26.withOpacity(0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movies!.title!,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        movies!.mediaType!,
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        movies!.overview!,
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        movies!.releaseDate!,
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        movies!.releaseDate!,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    ));
  }
}
