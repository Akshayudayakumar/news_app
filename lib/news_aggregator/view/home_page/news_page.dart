import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/news_aggregator/controller/trending_news_controller.dart';
import 'package:news_app/news_aggregator/services/user_data.dart';
import 'package:news_app/news_aggregator/view/all_news_screen/all_news_screen.dart';
import 'package:news_app/news_aggregator/view/detailed_news/detailed_news.dart';
import 'package:news_app/news_aggregator/view/home_page/widgets/news_card.dart';
import 'package:news_app/news_aggregator/view/home_page/widgets/trendingcard2.dart';
import 'package:news_app/news_aggregator/view/popular_news/popular_news_screen.dart';
import '../../controller/apicontroller.dart';


void main() {
  runApp(MaterialApp(home: NewsPage(),));
}

class NewsPage extends StatelessWidget {
  ApiController apiController = Get.put(ApiController());
  TrendingNewsController trendingNewsController =
  Get.put(TrendingNewsController());
  UserController controller = Get.put(UserController());


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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple[300],
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 114, 61, 205),
          centerTitle: true,
          leading: Icon(Icons.dehaze_rounded, color: Colors.white),
          title: Text(
            "Daily Brief",
            style: GoogleFonts.roboto(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                  showProfile(context);
              },
              child: Container(
                  height: 40,
                  width: 40,
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black26),
                  child: Center(
                      child: Image.asset("assets/icons/account-circle-line.png",
                          height: 30, width: 30, fit: BoxFit.cover))),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 8, right: 10, top: 5),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Trending...',
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.to(AllNewsScreen());
                      },
                      child: Text('See all',
                          style: Theme
                              .of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(color: Colors.white)),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Obx(
                      () =>
                  trendingNewsController.isLoading.value
                      ? CircularProgressIndicator()
                      : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      height: 300,
                      child: ListView.builder(
                        itemCount: trendingNewsController
                            .trendingnewslist2.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            TrendingCard(
                                name: trendingNewsController
                                    .trendingnewslist2[index].source.name,
                                time: formatDate(trendingNewsController
                                    .trendingnewslist2[index].publishedAt),
                                author: trendingNewsController
                                    .trendingnewslist2[index].author ??
                                    "Unknown",
                                onTap: () {
                                  Get.to(DetailedNewsScreen(
                                      news: trendingNewsController
                                          .trendingnewslist2[index]));
                                },
                                imageUrl: trendingNewsController
                                    .trendingnewslist2[index]
                                    .urlToImage ??
                                    "No image found",
                                description: trendingNewsController
                                    .trendingnewslist2[index]
                                    .description ??
                                    "No description",
                                title: trendingNewsController
                                    .trendingnewslist2[index].title),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Popular News',
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.to(PopularNewsScreen());
                      },
                      child: Text('See all',
                          style: Theme
                              .of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(color: Colors.white)),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Obx(
                      () =>
                  apiController.isLatest.value
                      ? CircularProgressIndicator()
                      : Column(
                    children: apiController.latestnewslist2.map((e) {
                      return NewsCard(
                        imageUrl: e.urlToImage ?? "Unknown",
                        title: e.title,
                        author: e.author ?? "Unknown",
                        time: e.publishedAt,
                        onTap: () {
                          Get.to(DetailedNewsScreen(news: e));
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showProfile(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Obx(() {
          return Dialog(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('UserInfo',
                      style:
                      GoogleFonts.roboto(fontSize: 24,fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Text(controller.name.value,
                      style:
                      GoogleFonts.aladin(fontSize: 20,fontWeight: FontWeight.w500)),
                  SizedBox(height: 10),
                  Text(
                    controller.email.value,
                    style: GoogleFonts.afacad(
                        fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Close"),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
