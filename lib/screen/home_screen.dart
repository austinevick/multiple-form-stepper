import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_ui_demo/model/movie_model.dart';
import 'package:movie_ui_demo/screen/movie_search_screen.dart';

import '../api.dart';
import 'movie_detail_screen.dart';

String BASE_IMAGE_URL = "https://image.tmdb.org/t/p/w500";

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Results> movies = [];
  ConnectivityResult? connectivityResult;
  Connectivity? connectivity;
  bool isConnected = false;
  @override
  void initState() {
    init();
    checkInternetConnection();
    super.initState();
  }

  Future<void> init() async {
    Future<List<Results>> movies = getTrendingMovies();
    await movies.then((value) => setState(() => this.movies = value));
  }

  checkInternetConnection() {
    InternetConnectionChecker().onStatusChange.listen((event) {
      final hasInternet = event == InternetConnectionStatus.connected;
      setState(() {
        isConnected = hasInternet;
        if (!hasInternet) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () async => await init(),
            ),
            duration: const Duration(seconds: 5),
            content: Row(
              children: const [
                Icon(Icons.wifi_off, color: Colors.white),
                SizedBox(width: 8),
                Text('No internet connection'),
              ],
            ),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
            content: Row(
              children: const [
                Icon(Icons.wifi, color: Colors.white),
                SizedBox(width: 8),
                Text('You are connected'),
              ],
            ),
          ));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Trending Movies'),
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MovieSearchScreen(),
                    )),
                icon: const Icon(Icons.search, size: 30))
          ],
        ),
        body: movies.isEmpty
            ? RefreshIndicator(
                onRefresh: () async => await init(),
                child: const Center(child: CircularProgressIndicator()))
            : RefreshIndicator(
                onRefresh: () async => await init(),
                child: ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, i) {
                    final m = movies[i];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                          reverseTransitionDuration: const Duration(seconds: 1),
                          transitionDuration: const Duration(seconds: 1),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
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
                ),
              ));
  }
}
