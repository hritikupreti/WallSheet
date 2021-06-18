import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pexels_api/helper/database.dart';
import 'package:pexels_api/views/photos.dart';
import 'package:pexels_api/widget/widgets.dart';

// ignore: use_key_in_widget_constructors
// ignore: must_be_immutable
class FavVideos extends StatefulWidget {
  bool? fromFav;
  String? doc;
  // ignore: use_key_in_widget_constructors
  FavVideos({this.fromFav});
  @override
  _FavVideosState createState() => _FavVideosState();
}

class _FavVideosState extends State<FavVideos> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? favVideos;

  @override
  void initState() {
    super.initState();
    getvideos();
  }

//getting data from database
  getvideos() async {
    await getVideos().then((e) {
      setState(() {
        favVideos = e;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isConnectiedToInternet
          ? StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: favVideos,
              builder: (context, snapshot) {
                return snapshot.data != null
                    ? ListView.builder(
                        itemCount: snapshot.data!.size,
                        itemBuilder: (context, index) {
                          return VideosPlayer(
                            fromFav: true,
                            url: snapshot.data!.docs[index]["Videourl"],
                            user: snapshot.data!.docs[index]["authorName"],
                            doc: snapshot.data!.docs[index].id,
                          );
                        })
                    : Container();
              },
            )
          : noInternet(context),
    );
  }
}
