import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/new_api_model.dart';

class ApiController extends GetxController {
  RxList<Article> trendingnewslist = <Article>[].obs;
  RxList<Article> trendingnewslist2 = <Article>[].obs;
  var latestnewslist = <Article>[].obs;
  RxList<Article> latestnewslist2 = <Article>[].obs;

  var isLoading = true.obs;
  var isTrending = false.obs;
  var isLatest = false.obs;


  final String apiKey = "b3f4c6ff67b5413ba65cb76d6d586a18";

  @override
  void onInit() async {
    super.onInit();
    await latestnews();
  }

  Future<void> latestnews() async {
    try {
      isLoading(true);

      final newsurl =
          "https://newsapi.org/v2/everything?q=apple&from=2025-02-11&to=2025-02-11&sortBy=popularity&apiKey=$apiKey";
      var response = await http.get(Uri.parse(newsurl));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        print(body);
        print("xxxxxxxxxxxxxxxxxxxxx");
        var news = NewsApimodel.fromJson(body);
        latestnewslist.value = news.articles;
        latestnewslist2.value = latestnewslist.sublist(0, 5).obs;
        print(latestnewslist);
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
