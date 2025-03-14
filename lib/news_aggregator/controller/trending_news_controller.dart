import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../model/new_api_model.dart';

class TrendingNewsController extends GetxController{
  String apiKey = "b3f4c6ff67b5413ba65cb76d6d586a18";
  var isLoading = false.obs;

  final format = DateFormat('MMM dd, yyyy');
  RxList<Article> trendingnewslist = <Article>[].obs;
  RxList<Article> trendingnewslist2 = <Article>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await trendingnews();
  }


  Future<void> trendingnews() async {
    try {
      isLoading(true);

      final newsurl =
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=$apiKey";
      var response = await http.get(Uri.parse(newsurl));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        print(body);
        print("xxxxxxxxxxxxxxxxxxxxx");
        NewsApimodel news = NewsApimodel.fromJson(body);
        var newslist = trendingnewslist.assignAll(news.articles);
        trendingnewslist.value  = news.articles;
        trendingnewslist2.value = trendingnewslist.sublist(0, 5).obs;
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