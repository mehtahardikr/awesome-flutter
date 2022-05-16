import 'package:flutter/material.dart';

class TabWidgetScreen extends StatefulWidget {
  @override
  State<TabWidgetScreen> createState() => _TabWidgetScreenState();
}

class _TabWidgetScreenState extends State<TabWidgetScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TabBar Widget'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.cloud_outlined),
                text: 'Cloud',
              ),
              Tab(
                icon: Icon(Icons.beach_access_sharp),
                text: 'Beach',
              ),
              Tab(
                icon: Icon(Icons.brightness_5_sharp),
                text: 'Beach',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: Text("It's cloudy here"),
            ),
            Center(
              child: Text("It's rainy here"),
            ),
            Center(
              child: Text("It's sunny here"),
            ),
          ],
        ),
      ),
    );
  }
}
