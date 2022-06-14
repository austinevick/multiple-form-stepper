import 'package:flutter/material.dart';
import 'package:movie_ui_demo/api.dart';
import 'package:movie_ui_demo/model/movie_model.dart';

class MovieSearchScreen extends StatefulWidget {
  const MovieSearchScreen({Key? key}) : super(key: key);

  @override
  State<MovieSearchScreen> createState() => _MovieSearchScreenState();
}

class _MovieSearchScreenState extends State<MovieSearchScreen> {
  List<Results> movies = [];
  List<Results> searchResult = [];
  bool isSearching = false;
  final query = TextEditingController();

  Future<void> init() async {
    Future<List<Results>> movies = getSearchMovies(query: query.text);
    await movies.then((value) => setState(() => this.movies = value));
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 60,
              child: Material(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: query,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w700),
                      onChanged: (value) {
                        setState(() {
                          searchResult = movies
                              .where((element) => element.title!
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                      decoration: const InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: 'Search'),
                    ),
                  )),
            ),
            const SizedBox(height: 15),
            Expanded(
                child: ListView(
              children: List.generate(searchResult.length,
                  (i) => Text(searchResult[i].originalTitle!)),
            )),
          ],
        ),
      ),
    );
  }
}
