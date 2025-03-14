import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../controller/apicontroller.dart';
import '../detailed_news/detailed_news.dart';
import '../home_page/widgets/news_card.dart';

void main(){
  runApp(MaterialApp(home: PopularNewsScreen(),));
}
class PopularNewsScreen extends StatelessWidget {
  ApiController apiController = Get.put(ApiController());

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
    return Scaffold(
      body: CustomScrollView(scrollDirection: Axis.vertical,
        slivers: [
          SliverAppBar(leading: IconButton(onPressed:(){
            Get.back();
          }, icon:Icon(Icons.arrow_back_ios_new_rounded) ),
            title: Text('Popular News', style: GoogleFonts.akatab(
                fontSize: 20, fontWeight: FontWeight.bold),),
            centerTitle: true,
            elevation: 3,
            floating: true,
            pinned: true,
            backgroundColor: Theme
                .of(context)
                .colorScheme
                .primaryContainer,
          ),
          SliverList(delegate: SliverChildListDelegate([
            Obx(() =>
            apiController.isLatest.value ? CircularProgressIndicator() :
            Column(
              children: apiController.latestnewslist.map((e) {
                return NewsCard(
                  imageUrl: e.urlToImage ?? "Unknown",
                  title: e.title,
                  author: e.author ?? "Unknown",
                  time: formatDate(e.publishedAt),
                  onTap: () {
                    Get.to(DetailedNewsScreen(news: e));
                  },);
              }).toList(),),
            ),
         ] ))
        ],
      ),
    );
  }
}
