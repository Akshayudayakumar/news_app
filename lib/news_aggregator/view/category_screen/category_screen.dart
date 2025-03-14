import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/news_aggregator/controller/fetchnews_controller.dart';
import 'package:news_app/news_aggregator/view/category_screen/widget/category_widget.dart';
import 'package:news_app/news_aggregator/view/detailed_news/detailed_news.dart';

class CategoryScreen extends StatelessWidget {
  final String category;

  CategoryScreen({super.key, required this.category});

  FetchNewsController controller = Get.put(FetchNewsController());

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
    double width = MediaQuery
        .of(context)
        .size
        .width;

    controller.fetchnews(category);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [ Container(
                width: width, height: 60,
                decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.elliptical(20, 30),
                        bottomRight: Radius.elliptical(20, 30))
                ),
              ),
                Padding(
                  padding: EdgeInsets.only(left: 10, top: 12),
                  child: GestureDetector(onTap: () {
                    Get.back();
                  },
                      child: Icon(Icons.arrow_back_ios_new_rounded, size: 28,
                          color: Colors.white)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Center(child:
                    Text(category,
                      style: GoogleFonts.alegreya(fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),),
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            Expanded(child: Obx(() {
              return ListView.builder(
                  itemCount: controller.categorynewslist.length,
                  itemBuilder: (context, index){
                     return GestureDetector(
                       onTap: (){
                         Get.to(DetailedNewsScreen(news: controller.categorynewslist[index]));
                       },
                       child: CategoryWidget(
                            imageUrl: controller.categorynewslist[index]
                                .urlToImage ?? "No image found",
                            title: controller.categorynewslist[index].title,
                            description: controller
                                .categorynewslist[index].description ??
                                "Unknown",
                         publishedAt: formatDate(controller.categorynewslist[index].publishedAt)
                       ),
                     );});
            }))
          ],
        ),
      ),
    );
  }
}
