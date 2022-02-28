import 'package:flutter/material.dart';
import 'package:movie_ui_demo/model/movie_model.dart';
import 'package:movie_ui_demo/screen/home_screen.dart';

class MovieDetailScreen extends StatelessWidget {
  final Results? movies;
  const MovieDetailScreen({Key? key, this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: movies!.id.toString(),
              child: SizedBox(
                  height: 550,
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                BASE_IMAGE_URL + movies!.posterPath!))),
                  )),
            ),
          ],
        ),
      )),
    );
  }
}
