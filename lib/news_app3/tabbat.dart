import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScrollableTabBarExample(),
    );
  }
}

class ScrollableTabBarExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text("Scrollable TabBar"),
          bottom: TabBar(
            isScrollable: true, // Makes the TabBar scrollable
            tabs: [
              Tab(text: "Home"),
              Tab(text: "Profile"),
              Tab(text: "Settings"),
              Tab(text: "Notifications"),
              Tab(text: "Messages"),
              Tab(text: "More"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text("Home Screen")),
            Center(child: Text("Profile Screen")),
            Center(child: Text("Settings Screen")),
            Center(child: Text("Notifications Screen")),
            Center(child: Text("Messages Screen")),
            Center(child: Text("More Screen")),
          ],
        ),
      ),
    );
  }
}
