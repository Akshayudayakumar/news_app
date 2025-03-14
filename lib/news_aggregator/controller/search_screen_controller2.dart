import 'dart:convert';

import 'package:get/get.dart';
import 'package:news_app/news_aggregator/model/new_api_model.dart';
import 'package:http/http.dart' as http;

class SearchNewsController extends GetxController{
  var isLoading = false.obs;
  RxList<Article> searchedArticle = <Article>[].obs;


  searchedResult({required String query}) async{
    try{
      isLoading(true);
      final url = Uri.parse(
          "https://newsapi.org/v2/everything?q=$query&from=2025-01-12&sortBy=publishedAt&apiKey=b3f4c6ff67b5413ba65cb76d6d586a18");
      final response = await http.get(url);
      if(response.statusCode == 200){
        var body = jsonDecode(response.body);
        final searchnews = NewsApimodel.fromJson(body);
        var newslist = searchedArticle.assignAll(searchnews.articles);
        searchedArticle.value = searchnews.articles;
        return newslist;
      }
    }catch(e){
      print("Exception caught : $e");
    }
  }
}