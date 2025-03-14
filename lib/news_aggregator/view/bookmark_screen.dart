import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/hive_controller.dart';

class SavedNewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsController = Get.find<NewsController>();
    return Scaffold(
      appBar: AppBar(title: Text("Saved Articles")),
      body: Obx(() {
        final articles = newsController.getSavedArticles();
        return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final article = articles[index];
            return ListTile(
              title: Text(article.title),
              subtitle: Text(article.description!),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  newsController.deleteArticle(article.title);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
