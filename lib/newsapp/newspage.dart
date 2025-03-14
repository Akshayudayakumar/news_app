import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'article_model.dart';
import 'controller.dart';

class NewsPage extends StatelessWidget {
  final NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Headlines'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              newsController.fetchArticles();
            },
          ),
        ],
      ),
      body: Obx(() {
        if (newsController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: newsController.articles.length,
          itemBuilder: (context, index) {
            final article = newsController.articles[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: article.urlToImage.isNotEmpty
                    ? Image.network(article.urlToImage, width: 100, fit: BoxFit.cover)
                    : const SizedBox(width: 100, child: Icon(Icons.image)),
                title: Text(article.title, maxLines: 2, overflow: TextOverflow.ellipsis),
                subtitle: Text(article.description, maxLines: 3, overflow: TextOverflow.ellipsis),
                onTap: () {
                  // Open the article in a web browser
                  Get.to(() => ArticleDetailPage(article: article));
                },
              ),
            );
          },
        );
      }),
    );
  }
}

class ArticleDetailPage extends StatelessWidget {
  final Article article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article.title)),
      body: Column(
        children: [
          article.urlToImage.isNotEmpty
              ? Image.network(article.urlToImage)
              : const Icon(Icons.image, size: 200),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(article.description),
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(() => WebViewPage(url: article.url));
            },
            child: const Text('Read More'),
          ),
        ],
      ),
    );
  }
}

class WebViewPage extends StatelessWidget {
  final String url;

  const WebViewPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Article')),
      body: Center(
        child: Text('WebView to open: $url'),
        // Replace with an actual WebView widget if needed
      ),
    );
  }
}
