import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'article_model.dart';
import 'newspage.dart';

class SavedArticlesPage extends StatelessWidget {
  final Box<Article> articleBox = Hive.box<Article>('articlesBox');

  @override
  Widget build(BuildContext context) {
    var savedArticles = articleBox.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Articles'),
      ),
      body: savedArticles.isEmpty
          ? const Center(
        child: Text('No saved articles'),
      )
          : ListView.builder(
        itemCount: savedArticles.length,
        itemBuilder: (context, index) {
          final article = savedArticles[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: article.urlToImage.isNotEmpty
                  ? Image.network(article.urlToImage, width: 100, fit: BoxFit.cover)
                  : const SizedBox(width: 100, child: Icon(Icons.image)),
              title: Text(article.title, maxLines: 2, overflow: TextOverflow.ellipsis),
              subtitle: Text(article.description, maxLines: 3, overflow: TextOverflow.ellipsis),
              onTap: () {
                Get.to(() => ArticleDetailPage(article: article));
              },
            ),
          );
        },
      ),
    );
  }
}
