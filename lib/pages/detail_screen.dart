import 'package:assigment/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

class DetailScreen extends StatelessWidget {
  String removeHtmlTags(String htmlString) {
    final document = parse(htmlString);
    return document.body?.text ?? '';
  }

  final Movie movie;
  const DetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(movie.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                movie.imageUrl.isNotEmpty
                    ? Image.network(movie.imageUrl)
                    : Container(
                        height: 200,
                        color: Colors.grey,
                      ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  removeHtmlTags(movie.title),
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                SingleChildScrollView(
                  child: Text(
                    removeHtmlTags(movie.summary),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
