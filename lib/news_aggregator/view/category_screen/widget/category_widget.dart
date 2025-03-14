import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:loading_container_flutter/loading_container_flutter.dart';

class CategoryWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String publishedAt;
  const CategoryWidget({super.key, required this.imageUrl, required this.title, required this.description, required this.publishedAt});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 20,right: 20),
          height: height/3.7,width:width,
          decoration: BoxDecoration(),
          child: ClipRRect(borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(imageUrl: imageUrl,fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Shimmer.fromColors(baseColor:Colors.grey, highlightColor:Colors.white, child:LoadingContainerWidget(width: width,height: height,)),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ))),
        SizedBox(height: 5),

        Row(children: [
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Text(title,
              style: GoogleFonts.roboto(fontSize: 18,fontWeight: FontWeight.w900),),
          ),
          SizedBox(width: 10),
          Flexible(child: Text(publishedAt,style: GoogleFonts.roboto(fontSize: 10),)),
        ],),
        SizedBox(height: 7),
        Padding(
          padding: EdgeInsets.only(left: 10,right: 10),
          child: Text(description,
            style: GoogleFonts.roboto(fontSize: 14),),
        ),
        Divider(thickness: 1,color: Colors.grey,)

      ],
    );
  }
}
