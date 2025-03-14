import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/news_aggregator/controller/trending_news_controller.dart';
import 'package:news_app/news_aggregator/view/detailed_news/detailed_news.dart';
import 'package:news_app/news_aggregator/view/home_page/widgets/trendingcard.dart';

void main(){
  runApp(MaterialApp(home: AllNewsScreen(),));
}
class AllNewsScreen extends StatelessWidget {
 TrendingNewsController trendingNewsController = Get.put(TrendingNewsController());

 String formatDate(String dateString) {
   try {
     DateTime date = DateTime.parse(dateString);
     return DateFormat('MMMM dd, yyyy').format(date);
   } catch (e) {
     return 'Invalid date';
   }
 }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: CustomScrollView(
            slivers: [
              SliverAppBar(leading: IconButton(onPressed:(){
                Get.back();
              }, icon:Icon(Icons.arrow_back_ios_new_rounded) ),
                title: Text('Trending News', style: GoogleFonts.akatab(
                    fontSize: 20, fontWeight: FontWeight.bold),),
                centerTitle: true,
                backgroundColor: Theme
                    .of(context)
                    .colorScheme
                    .primaryContainer,
              ),
              Obx(() {
                return 
                  SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                            childCount: trendingNewsController.trendingnewslist.length,
                                (context, index) =>
                                TrendingCard(
                                    name: trendingNewsController.trendingnewslist[index]
                                        .source.name,
                                    time:formatDate(trendingNewsController.trendingnewslist[index].publishedAt),
                                    author: trendingNewsController.trendingnewslist[index]
                                        .author ?? "Unknown",
                                    onTap: () {
                                      Get.to(DetailedNewsScreen(news: trendingNewsController.trendingnewslist
                                          [index]));
                                    },
                                    imageUrl: trendingNewsController.trendingnewslist[index]
                                        .urlToImage ?? "No image found",
                                    description: trendingNewsController.trendingnewslist
                                        [index].description ?? "No Description",
                                    title: trendingNewsController.trendingnewslist[index]
                                        .title,)),

                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1)
                  );
              })
            ]
        )
    );
  }
}
