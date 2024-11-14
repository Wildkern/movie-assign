class Movie {
  final String title;
  final String summary;
  final String imageUrl;

  Movie({required this.title, required this.summary, required this.imageUrl});

  //  Factory constructor to create a Movie object from json
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['show']['name'] ?? 'N/A',
      summary: json['show']['summary'] ?? 'No summary available',
      imageUrl: json['show']['image']?['medium'] ?? '',
    );
  }
}
