import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_total/src/model/trending_movie_model.dart';

import '../../model/popular_movie_model.dart';

class ApiServices {
  // final String category;
  // ApiServices({required this.category});

  final apiKey = 'api_key=5c715122a3acf71fa6de2524dff86151';

  //Treanding Articles
  Future<TrendingMovie> fetchTopRatedMovie() async {
    final response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/top_rated?api_key=5c715122a3acf71fa6de2524dff86151"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return TrendingMovie.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }

//Popular movies
Future<PopularMovie> fetchPopularMovie() async {
    final response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/popular?api_key=5c715122a3acf71fa6de2524dff86151"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return PopularMovie.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }
}
