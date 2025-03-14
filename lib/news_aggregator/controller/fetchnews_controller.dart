import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/new_api_model.dart';

class FetchNewsController extends GetxController{
  String apiKey = "b3f4c6ff67b5413ba65cb76d6d586a18";
  var isLoading = false.obs;

  RxList<Article> categorynewslist = <Article>[].obs;

  var categorylist = ["Business", "Entertainment", "Health", "Science", "Sports", "Technology"].obs;

  Future<void> fetchnews(String category) async {
    try {
      isLoading(true);

      final newsurl =
          "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=b3f4c6ff67b5413ba65cb76d6d586a18$apiKey";
      var response = await http.get(Uri.parse(newsurl));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        print(body);
        print("xxxxxxxxxxxxxxxxxxxxx");
        NewsApimodel news = NewsApimodel.fromJson(body);
       var newslist = categorynewslist.assignAll(news.articles);
        categorynewslist.value  = news.articles;
        return newslist;

      } else {
        print("Failed to load news : ${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }
}