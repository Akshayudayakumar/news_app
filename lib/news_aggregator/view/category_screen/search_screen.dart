import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/news_aggregator/view/home_page/widgets/news_card.dart';
import '../../controller/search_screen_controller2.dart';

class SearchScreen extends StatelessWidget {
  SearchNewsController controller = Get.put(SearchNewsController());
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Theme
            .of(context)
            .colorScheme
            .primaryContainer,
          leading:IconButton(onPressed: (){
            Get.back();
          }, icon: Icon(Icons.arrow_back_ios_new_rounded,size: 25,color: Colors.purple,)),
        ),
        body: Column(
          children: [
            SizedBox(height: 5),
        Container(margin: EdgeInsets.only(left: 10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme
                    .of(context)
                    .colorScheme
                    .primaryContainer
            ), child:
        Row(
          children: [
        Expanded(child: TextField(controller: searchController,
          onChanged: (value) {
            if (searchController.text.length > 3) {
              controller.searchedResult(query: searchController.text);
            }
          },
          decoration: InputDecoration(hintText: "Search News...",
              fillColor: Theme
                  .of(context)
                  .colorScheme
                  .primaryContainer,
              border: InputBorder.none,
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              )
          ),)),
        InkWell(
          onTap: () {
            if (searchController.text.isNotEmpty) {
              controller.searchedResult(query: searchController.text);
            }
          },
          child: Container(width: 50, height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme
                  .of(context)
                  .colorScheme
                  .primary,
            ), child: Icon(Icons.search),
          ),
        )
              ],
            ),
        ),

            SizedBox(height: 15),
            Obx(() {
              return Expanded(child:
              ListView.separated(itemBuilder: (context, index) =>
                  NewsCard(
                      imageUrl: controller.searchedArticle[index].urlToImage ?? "Unknown",
                      author: controller.searchedArticle[index].author ??
                          "Unknown",
                      time: '',
                      title: controller.searchedArticle[index].title,
                      onTap: () {}),
                  separatorBuilder: (context, index) =>
                      Divider(
                        thickness: .5,
                        indent: 30,
                        endIndent: 30,
                      ),
                  itemCount: controller.searchedArticle.length)
              );
            }),
          ],
        ),
      ),
    );
  }
}
