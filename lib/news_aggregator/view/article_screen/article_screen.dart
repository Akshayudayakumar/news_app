import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/news_aggregator/controller/fetchnews_controller.dart';
import 'package:news_app/news_aggregator/view/article_screen/widget/search_bar.dart';
import 'package:news_app/news_aggregator/view/category_screen/category_screen.dart';
import 'package:news_app/news_aggregator/view/category_screen/search_screen.dart';

class ArticleScreen extends StatelessWidget {
  FetchNewsController controller = Get.put(FetchNewsController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {
                    Get.to(SearchScreen());
                  },
                  child: SearchBarWidget()),
              SizedBox(height: 20),
              Text(
                "EXPLORE",
                style: GoogleFonts.merriweather(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Obx(() {
                return Expanded(
                  child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: controller.categorylist.length,
                      itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Get.to(CategoryScreen(
                                  category: controller.categorylist[index]));
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 20, top: 20),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blue),
                              child: Center(
                                  child: Text(
                                controller.categorylist[index],
                                style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          )),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
