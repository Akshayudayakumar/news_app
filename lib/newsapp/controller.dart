import 'dart:convert';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'article_model.dart';

class NewsController extends GetxController {
  var articles = <Article>[].obs;
  var isLoading = true.obs;
  late Box<Article> articleBox;

  @override
  void onInit() {
    super.onInit();
    articleBox = Hive.box<Article>('articlesBox');
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    isLoading(true);
    const apiKey = "b3f4c6ff67b5413ba65cb76d6d586a18";
    const url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> articlesJson = data['articles'];
        final List<Article> fetchedArticles = articlesJson
            .map((json) => Article.fromJson(json))
            .toList();

        // Save to Hive
        articleBox.clear();
        for (var article in fetchedArticles) {
          articleBox.add(article);
        }

        articles.value = fetchedArticles;
      } else {
        // Load from Hive in case of API failure
        articles.value = articleBox.values.toList();
      }
    } catch (e) {
      // Load cached data if an error occurs
      articles.value = articleBox.values.toList();
    } finally {
      isLoading(false);
    }
  }
}
