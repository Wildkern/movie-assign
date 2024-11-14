import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:assigment/models/movie.dart';

class ApiService {
  Future<List<Movie>> fetchMovies(String query) async {
    final url = Uri.parse('https://api.tvmaze.com/search/shows?q=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load Movies');
    }
  }
}
