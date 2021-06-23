import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pexels_api/helper/database.dart';
import 'package:pexels_api/widget/tostmessage.dart';
import 'package:pexels_api/widget/widgets.dart';

// ignore: must_be_immutable
class ImageView extends StatefulWidget {
  String url;
  String? photographerName;
  bool fromFav;
  QueryDocumentSnapshot<Map<String, dynamic>>? doc;
  // ignore: use_key_in_widget_constructors
  ImageView(
      {required this.url,
      required this.photographerName,
      this.doc,
      required this.fromFav});
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  bool isfav = false;
  void setDialog(BuildContext context) {
    var alertDialog = AlertDialog(
      backgroundColor: Colors.white.withOpacity(0.8),
      elevation: 0,
      title: const Text("Set mage as", style: TextStyle(color: Colors.black)),
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () {
                setASHomeScreen(widget.url);
                Navigator.pop(context);
              },
              child: const Text("Home screen",
                  style: TextStyle(color: Colors.black)),
            ),
            const Divider(
              thickness: 1,
            ),
            // ignore: deprecated_member_use
            FlatButton(
                onPressed: () {
                  setASLockScreen(widget.url);
                  Navigator.pop(context);
                },
                child: const Text("Lock screen",
                    style: TextStyle(color: Colors.black))),
            const Divider(
              thickness: 1,
            ),

            // ignore: deprecated_member_use
            FlatButton(
                onPressed: () {
                  setASBothScreen(widget.url);
                  Navigator.pop(context);
                },
                child:
                    const Text("Both", style: TextStyle(color: Colors.black))),
          ],
        )
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // ignore: sized_box_for_whitespace
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(widget.url, fit: BoxFit.cover),
          Positioned(
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 30),
              child: Container(
                height: 55,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text("by ~",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w300)),
                      Center(
                        child: Text(widget.photographerName!,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  if (widget.fromFav) {
                    delete(widget.doc!.id);
                    Navigator.pop(context);
                    showRemoveFromFavMessage();
                  } else {
                    Map<String, dynamic> imageDetailMap = {
                      "Imageurl": widget.url,
                      "autherName": widget.photographerName!,
                      "time": DateTime.now().microsecondsSinceEpoch
                    };
                    addImageToFav(imageDetailMap);
                    if (isfav) {
                      warningMessage();
                    } else {
                      showAddToFavMeaasge();
                    }
                    setState(() {
                      isfav = true;
                    });
                  }
                },
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 25, top: 45, bottom: 15),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: widget.fromFav
                            ? const Icon(
                                Icons.favorite_outlined,
                                size: 27,
                                color: Colors.red,
                              )
                            : isfav
                                ? const Icon(
                                    Icons.favorite_outlined,
                                    size: 27,
                                    color: Colors.red,
                                  )
                                : const Icon(
                                    Icons.favorite_border_sharp,
                                    size: 27,
                                    color: Colors.red,
                                  ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setDialog(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 25, top: 15, bottom: 15),
                        child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: const Icon(
                              Icons.downloading_outlined,
                              size: 27,
                            )),
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    ));
  }
}
