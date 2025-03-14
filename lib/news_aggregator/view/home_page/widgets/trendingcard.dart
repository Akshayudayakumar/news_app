import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_container_flutter/loading_container_flutter.dart';

class TrendingCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String time;
  final String description;
  final String title;
  final String author;
  final VoidCallback onTap;

  const TrendingCard(
      {super.key,
      required this.name,
      required this.time,
      required this.author,
      required this.onTap,
      required this.imageUrl,
      required this.description,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.only(left: 50, bottom: 10),
            padding: EdgeInsets.all(5),
            height: 300,
            width: 280,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    height: 180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).cardColor),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => LoadingContainerWidget(
                            height: 40,
                            colorOne: Colors.grey,
                            colorTwo: Colors.purpleAccent,
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        )),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Text(time, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: TextStyle(fontSize: 15),
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                        child: FaIcon(
                      FontAwesomeIcons.bookmark,
                      color: Colors.white,
                      size: 25,
                    )),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.orange,
                      child: Center(child: Text(author[0])),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                        child: Text(
                      author,
                      maxLines: 2,
                      style: TextStyle(fontSize: 15),
                    ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
