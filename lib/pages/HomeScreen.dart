import 'package:assigment/models/api_service.dart';
import 'package:assigment/models/movie.dart';
import 'package:assigment/pages/detail_screen.dart';
import 'package:assigment/pages/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String removeHtmlTags(String htmlString) {
    final document = parse(htmlString);
    return document.body?.text ?? '';
  }

  final ApiService apiService = ApiService();
  late Future<List<Movie>> movies;
  @override
  void initState() {
    super.initState();
    movies = apiService.fetchMovies("all");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Movies'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
              },
            )
          ],
        ),
        body: FutureBuilder<List<Movie>>(
          future: movies,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error:${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No movies found'),
              );
            }
            final movieList = snapshot.data!;

            return ListView.builder(
                itemCount: movieList.length,
                itemBuilder: (context, index) {
                  final movie = movieList[index];
                  return ListTile(
                    leading: movie.imageUrl.isNotEmpty
                        ? Image.network(movie.imageUrl,
                            width: 50, fit: BoxFit.cover)
                        : Container(
                            width: 50,
                            color: Colors.grey,
                          ),
                    title: Text(movie.title),
                    subtitle: Text(
                      removeHtmlTags(movie.summary),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(movie: movie),
                        ),
                      );
                    },
                  );
                });
          },
        ));
  }
}
