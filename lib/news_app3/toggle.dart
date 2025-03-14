import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ToggleExample(),
    );
  }
}

class ToggleExample extends StatefulWidget {
  @override
  _ToggleExampleState createState() => _ToggleExampleState();
}

class _ToggleExampleState extends State<ToggleExample> {
  bool isOn = true;
  bool isVALID = false;// Initial state

  void toggleState() {
    isVALID;
    setState(() {
      isOn = !isOn; // Toggle state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SetState Toggle Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isOn ? "ON" : "OFF",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: toggleState,
              child: Text("Toggle"),
            ),
          ],
        ),
      ),
    );
  }
}
