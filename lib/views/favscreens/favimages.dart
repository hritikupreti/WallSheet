import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pexels_api/helper/database.dart';
import 'package:pexels_api/views/photos.dart';
import 'package:pexels_api/widget/widgets.dart';

import '../imageview.dart';

// ignore: use_key_in_widget_constructors
class FavImage extends StatefulWidget {
  @override
  _FavImageState createState() => _FavImageState();
}

class _FavImageState extends State<FavImage> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? favphotos;

  @override
  void initState() {
    super.initState();
    getphotos();
  }

//getting data from database
  getphotos() async {
    await getImages().then((e) {
      setState(() {
        favphotos = e;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isConnectiedToInternet
        ? StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: favphotos,
            builder: (context, snapshot) {
              return snapshot.data != null
                  ? GridView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: snapshot.data!.size,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (BuildContext context, int index) {
                        return FavImagetile(
                          photographerName: snapshot.data!.docs[index]
                              ["autherName"],
                          url: snapshot.data!.docs[index]["Imageurl"],
                          doc: snapshot.data!.docs[index],
                        );
                      })
                  : Container();
            })
        : noInternet(context);
  }
}

// ignore: use_key_in_widget_constructors
class FavImagetile extends StatelessWidget {
  final String url;
  final String? photographerName;
  final QueryDocumentSnapshot<Map<String, dynamic>> doc;
  // ignore: use_key_in_widget_constructors
  const FavImagetile(
      {required this.photographerName, required this.url, required this.doc});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ImageView(
                      url: url,
                      photographerName: photographerName,
                      doc: doc,
                      fromFav: true,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 4, left: 3, right: 3, bottom: 3),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            url,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
