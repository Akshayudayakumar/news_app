import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/news_aggregator/services/user_data.dart';

import '../home_page/news_page.dart';

class ProfileScreen extends StatefulWidget {

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkMode = false;
  bool isNotificationEnabled = true;
  String? name;
  UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        leading: IconButton(onPressed: () {
          Get.to(NewsPage());
        },
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.purple,
                size: 20)),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Username', style: GoogleFonts.roboto(
                        fontSize: 15, fontWeight: FontWeight.bold),),
                    SizedBox(width: 12),
                    Flexible(
                      child: Material(
                        elevation: 3, borderRadius: BorderRadius.circular(20),
                        child: Container(

                          height: 30, width: MediaQuery
                            .of(context)
                            .size
                            .width,
                          decoration: BoxDecoration(borderRadius: BorderRadius
                              .circular(20),
                            color: Theme
                                .of(context)
                                .colorScheme
                                .primaryContainer,
                          ),
                          child: Center(child: Obx(() {
                            return Text(controller.name.value,style: GoogleFonts.roboto(fontSize: 13,color: Colors.black),);
                          })),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text('Email', style: GoogleFonts.roboto(
                        fontSize: 15, fontWeight: FontWeight.bold),),
                    SizedBox(width: 40),
                    Flexible(
                      child: Material(
                        elevation: 3, borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 30, width: MediaQuery
                            .of(context)
                            .size
                            .width,
                          decoration: BoxDecoration(borderRadius: BorderRadius
                              .circular(20),
                            color: Theme
                                .of(context)
                                .colorScheme
                                .secondaryContainer,
                          ),
                          child: Center(child: Obx(() {
                            return Text(controller.email.value,style: GoogleFonts.roboto(fontSize: 13,color: Colors.black));
                          })),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: const Text("Bookmarks"),
            onTap: () {
              // Handle bookmarks
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.notifications),
            title: const Text("Notifications"),
            value: isNotificationEnabled,
            onChanged: (bool value) {
              setState(() {
                isNotificationEnabled = value;
              });
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.brightness_4),
            title: const Text("Dark Mode"),
            value: isDarkMode,
            onChanged: (bool value) {
              setState(() {
                isDarkMode = value;
                // Implement dark mode toggle here
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Language"),
            onTap: () {
              // Handle language selection
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Privacy Policy"),
            onTap: () {
              // Handle privacy policy
            },
          ),
          ListTile(
            leading: const Icon(Icons.file_copy),
            title: const Text("Terms of Use"),
            onTap: () {
              // Handle terms of use
            },
          ),
        ],
      ),
    );
  }
}