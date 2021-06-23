import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/painting.dart';
import 'package:pexels_api/helper/auth.dart';
import 'package:pexels_api/views/favscreens/fav.dart';
import 'package:pexels_api/views/photos.dart';
import 'package:pexels_api/views/videos.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: use_key_in_widget_constructors
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
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
    signIn();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  signIn() async {
    dynamic result = await signInAnom();
    if (result == null) {
      // ignore: avoid_print
      print("signing in faild");
    } else {
      // ignore: avoid_print
      print("signing is sucessful");
    }
  }

  // ignore: non_constant_identifier_names

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text("Wall",
                  style: GoogleFonts.josefinSans(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.w700)),
              Text("Sheet",
                  style: GoogleFonts.josefinSans(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w700))
            ],
          ),
          bottom: TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.white,
            labelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: const BubbleTabIndicator(
              indicatorHeight: 25.0,
              indicatorColor: Colors.greenAccent,
              tabBarIndicatorSize: TabBarIndicatorSize.label,
            ),
            tabs: tabs,
            controller: _tabController,
          ),
          elevation: 0.0,
        ),
        body: TabBarView(controller: _tabController, children: <Widget>[
          Center(child: PhotosView()),
          Center(child: VideosViews())
        ]),
        floatingActionButton: FloatingActionButton(
            heroTag: "btn1",
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavScreen()));
            },
            child: const Icon(
              Icons.favorite,
              color: Color(0xFFFCE4EC),
            )));
  }
}
