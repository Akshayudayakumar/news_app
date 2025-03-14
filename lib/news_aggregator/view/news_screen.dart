import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/hive_controller.dart';

class NewsScreen extends StatelessWidget {
  final NewsController controller = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News App with GetX & Hive')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: controller.fetchNews,
            child: Text('Fetch News'),
          ),
          Expanded(
            child: Obx(() {
              if (controller.articles.isEmpty) {
                return Center(child: Text('No news available'));
              }
              return ListView.builder(
                itemCount: controller.articles.length,
                itemBuilder: (context, index) {
                  final article = controller.articles[index];
                  return ListTile(
                    title: Text(article.title),
                    subtitle: Text(article.description),
                    leading: article.urlToImage.isNotEmpty
                        ? Image.network(article.urlToImage, width: 50, height: 50, fit: BoxFit.cover)
                        : null,
                    trailing: IconButton(
                      icon: Icon(Icons.save),
                      onPressed: () => controller.saveArticle(article),
                    ),
                  );
                },
              );
            }),
          ),
          Text('Saved Articles', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.articleBox.length,
                itemBuilder: (context, index) {
                  final article = controller.articleBox.getAt(index);
                  return ListTile(
                    title: Text(article!.title),
                    subtitle: Text(article.description),
                    leading: article.urlToImage.isNotEmpty
                        ? Image.network(article.urlToImage, width: 50, height: 50, fit: BoxFit.cover)
                        : null,
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => controller.deleteArticle(index),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
