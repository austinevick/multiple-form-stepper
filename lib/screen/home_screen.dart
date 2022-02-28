import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movie_ui_demo/model/movie_model.dart';

import 'movie_detail_screen.dart';

String BASE_IMAGE_URL = "https://image.tmdb.org/t/p/w500";

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Results> movies = [];
  Future<List<Results>> getTrendingMovies() async {
    final response = await get(Uri.parse(
        'https://api.themoviedb.org/3/trending/all/day?api_key=dcb8565b1508cc35b50fbacaf9f52628'));
    if (response.statusCode == 200) {
      Iterable list = jsonDecode(response.body)['results'];
      print(list);
      return list.map((e) => Results.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    ini();
    super.initState();
  }

  ini() async {
    Future<List<Results>> movies = getTrendingMovies();
    await movies.then((value) => setState(() => this.movies = value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Trending Movies'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
        body: movies.isEmpty
            ? const Center()
            : ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, i) {
                  final m = movies[i];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                        reverseTransitionDuration: const Duration(seconds: 1),
                        transitionDuration: const Duration(seconds: 1),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            FadeTransition(
                          opacity: animation,
                          child: MovieDetailScreen(movies: m),
                        ),
                      ));
                    },
                    child: Hero(
                      tag: m.id.toString(),
                      child: SizedBox(
                          height: 250,
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 25, right: 25, top: 8, bottom: 8),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Column(
                                  children: [
                                    const Spacer(),
                                    Text(
                                      m.title!,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    )
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                      colorFilter: const ColorFilter.mode(
                                          Colors.black54, BlendMode.darken),
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          BASE_IMAGE_URL + m.posterPath!))),
                            ),
                          )),
                    ),
                  );
                },
              ));
  }
}
