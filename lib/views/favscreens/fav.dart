import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:pexels_api/views/favscreens/favvideos.dart';
import 'package:pexels_api/views/favscreens/favimages.dart';

// ignore: use_key_in_widget_constructors
class FavScreen extends StatefulWidget {
  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    const Tab(
      text: "Photos",
    ),
    const Tab(text: "Videos"),
  ];
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red[400],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text(
              "Favo",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            const Text("urites",
                style: TextStyle(fontSize: 20, color: Colors.white))
          ],
        ),
        bottom: TabBar(
          isScrollable: true,
          unselectedLabelColor: Colors.white,
          labelColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: const BubbleTabIndicator(
            indicatorHeight: 25.0,
            indicatorColor: Color(0xFFFCE4EC),
            tabBarIndicatorSize: TabBarIndicatorSize.label,
          ),
          tabs: tabs,
          controller: _tabController,
        ),
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.pink[50],
        child: TabBarView(controller: _tabController, children: <Widget>[
          Center(child: FavImage()),
          Center(child: FavVideos())
        ]),
      ),
    );
  }
}
