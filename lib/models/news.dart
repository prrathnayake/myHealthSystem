class News {
  final dynamic title;
  final dynamic urlToImage;
  final dynamic content;

  const News({
    required this.title,
    required this.urlToImage,
    required this.content,
  });

  factory News.fromJson(Map<dynamic, dynamic> json) {
    return News(
      title: json['title'],
      urlToImage: json['urlToImage'],
      content: json['content'],
    );
  }
}
