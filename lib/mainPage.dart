


import 'package:flutter/material.dart';
import 'package:greenlight/main/communicationPage.dart';
import 'package:greenlight/main/mapPage.dart';
import 'package:greenlight/main/settingPage.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage> with SingleTickerProviderStateMixin {
  TabController? controller;

  String _databaseURL = '###';
  String? id;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);

  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    id = ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
      body: TabBarView(
        children: <Widget>[
          // TabBarView에 채울 위젯들
          MapPage(),
          CommunicationPage(),
          SettingPage()
        ],
        controller: controller,
      ),
      bottomNavigationBar: TabBar(
        tabs: <Tab>[
          Tab(
            icon: Icon(Icons.map),
          ),
          Tab(
            icon: Icon(Icons.star),
          ),
          Tab(
            icon: Icon(Icons.settings),
          )
        ],
        labelColor: Colors.amber,
        indicatorColor: Colors.deepOrangeAccent,
        controller: controller,
      ),);
    throw UnimplementedError();
  }
}