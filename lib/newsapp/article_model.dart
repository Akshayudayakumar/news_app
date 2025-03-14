import 'package:hive/hive.dart';
part 'article_model.g.dart';

@HiveType(typeId: 1)
class Article {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String urlToImage;

  @HiveField(3)
  final String url;

  Article({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.url,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      urlToImage: json['urlToImage'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
