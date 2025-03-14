import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/news_aggregator/model/new_api_model.dart';
import '../../controller/hive_controller.dart';

class DetailedNewsScreen extends StatelessWidget {
  final Article news;
  const DetailedNewsScreen({super.key, required this.news});

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor:Theme.of(context).colorScheme.secondaryContainer,
        body: Padding(
          padding: EdgeInsets.all(10),
          child: 
          SingleChildScrollView(
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(color: Colors.black38,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back_ios_outlined,
                              color: Colors.white,
                              size: 28,
                            ),
                          )),
                    ),
                    GestureDetector(
                    onTap: () {
    final newsController = Get.find<NewsController>();
    newsController.saveArticle(news);
    Get.snackbar('Saved', 'Article saved successfully');
    },
                     child:  Container(
                        height: 40,
                        width: 40,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(color: Colors.black38,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(child: FaIcon(
                          FontAwesomeIcons.bookmark, color: Colors.white,
                          size: 25,)),
                      ),

    ),
          ],
                    ),
                SizedBox(height: 20),
                Container(
                                width: width,
                                height: height/3,
                                child: ClipRRect(borderRadius: BorderRadius.circular(20),
                                    child: Image.network(news.urlToImage!,fit: BoxFit.cover,)),
                              ),
                SizedBox(height: 20),
                Text(news.description!,style: GoogleFonts.alegreya(fontSize: 24,fontWeight: FontWeight.bold),),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(formatDate(news.publishedAt),
                      style: Theme.of(context).textTheme.bodySmall,),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    CircleAvatar(backgroundColor: Colors.amber,radius: 15,
                      child: Center(child: Text(news.author![0])),),
                    SizedBox(width: 10),
                    Text(news.author!,style: GoogleFonts.roboto(fontSize: 18,fontWeight: FontWeight.bold),)
                  ],
                ),
                SizedBox(height: 10),
                Text(news.content!,style: GoogleFonts.roboto(fontSize: 17),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
