import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pexels_api/helper/database.dart';
import 'package:pexels_api/views/photos.dart';
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
                height: 45,
                width: 220,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text("by ~",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w300)),
                        Text(widget.photographerName!,
                            style: const TextStyle(
                                fontSize: 22, color: Colors.white)),
                      ],
                    ),
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
                    Map<String, String> imageDetailMap = {
                      "Imageurl": widget.url,
                      "autherName": widget.photographerName!,
                    };
                    addImageToFav(imageDetailMap);
                    setState(() {
                      isfav = true;
                    });
                    if (isfav) {
                      warningMessage();
                    }
                  }
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 45, horizontal: 25),
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
              ))
        ],
      ),
    ));
  }
}
