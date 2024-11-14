import 'package:assigment/models/api_service.dart';
import 'package:assigment/pages/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import '../models/movie.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String removeHtmlTags(String htmlString) {
    final document = parse(htmlString);
    return document.body?.text ?? '';
  }

  final ApiService apiService = ApiService();
  List<Movie> searchResults = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  String? _error;

  void _searchMovies(String query) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final results = await apiService.fetchMovies(query);
      setState(() {
        searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(hintText: 'Search movies...'),
          onSubmitted: _searchMovies,
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : searchResults.isEmpty
                  ? Center(child: Text('No results found'))
                  : ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final movie = searchResults[index];
                        return ListTile(
                          leading: movie.imageUrl.isNotEmpty
                              ? Image.network(movie.imageUrl,
                                  width: 50, fit: BoxFit.cover)
                              : Container(width: 50, color: Colors.grey),
                          title: Text(removeHtmlTags(movie.title)),
                          subtitle: SingleChildScrollView(
                            child: Text(
                              removeHtmlTags(movie.summary),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailScreen(movie: movie),
                              ),
                            );
                          },
                        );
                      },
                    ),
    );
  }
}
