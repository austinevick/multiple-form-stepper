import 'dart:convert';

import 'package:http/http.dart';

import 'model/movie_model.dart';

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

Future<List<Results>> getSearchMovies({String query = 'spiderman'}) async {
  final response = await get(Uri.parse(
      'https://api.themoviedb.org/3/search/movie?api_key=dcb8565b1508cc35b50fbacaf9f52628&query=$query&page=1&include_adult=false'));
  if (response.statusCode == 200) {
    Iterable list = jsonDecode(response.body)['results'];
    print(list);
    return list.map((e) => Results.fromJson(e)).toList();
  } else {
    throw Exception(response.reasonPhrase);
  }
}
