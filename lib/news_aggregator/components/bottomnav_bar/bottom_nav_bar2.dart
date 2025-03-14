import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/news_aggregator/view/archived_page.dart';
import 'package:news_app/news_aggregator/view/profile_screen/profile_screen.dart';
import '../../controller/bottom_navigation_controller.dart';
import '../../view/article_screen/article_screen.dart';
import '../../view/home_page/news_page.dart';

class HomeScreen extends StatelessWidget {
  BottomNavigationController controller =
  Get.put(BottomNavigationController());

   List<Widget> pages = [
  NewsPage(),ArticleScreen(),ArchivedPage(),ProfileScreen()].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[controller.selectedIndex.value]),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavigationItem(Icons.home, 0),
            buildNavigationItem(Icons.search, 1),
            buildNavigationItem(Icons.bookmark,2),
            buildNavigationItem(Icons.person, 3),
          ],
        )),
      ),
    );
  }

  Widget buildNavigationItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () => controller.changedIndex(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,size: 25,
            color: controller.selectedIndex.value == index
                ? Colors.purple
                : Colors.black,
          ),
          if (controller.selectedIndex.value == index)
            Container(
              height: 3,
              width: 20,
              color: Colors.purpleAccent,
              margin: EdgeInsets.only(top: 5),
            ),
        ],
      ),
    );
  }
}
