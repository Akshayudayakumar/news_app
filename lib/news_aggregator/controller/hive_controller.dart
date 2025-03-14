import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:news_app/news_aggregator/model/new_api_model.dart';

class NewsController extends GetxController {
  final Box<Article> newsBox = Hive.box<Article>('newsBox');

  void saveArticle(Article article) {
    newsBox.put(article.title, article);
    update();
  }

  List<Article> getSavedArticles() {
    return newsBox.values.toList();
  }

  void deleteArticle(String title) {
    newsBox.delete(title);
    update();
  }
}
