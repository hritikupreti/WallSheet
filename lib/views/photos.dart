import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:pexels_api/helper/data.dart';
import 'package:pexels_api/models/photomodel.dart';
import 'package:pexels_api/widget/widgets.dart';

// ignore: use_key_in_widget_constructors
class PhotosView extends StatefulWidget {
  @override
  _Photos_viewState createState() => _Photos_viewState();
}

List<PhotoModels> photomodels = <PhotoModels>[];
bool isConnectiedToInternet = true;

// ignore: camel_case_types
class _Photos_viewState extends State<PhotosView> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    checkInternetConnectivity();
    getPhoto();
  }

  checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      setState(() {
        isConnectiedToInternet = false;
      });
    } else {
      setState(() {
        isConnectiedToInternet = true;
      });
    }
  }

  getPhoto() async {
    PhotoData data = PhotoData();
    await data.getPhotos();
    photomodels = data.photos!;
    await data.getPhotos();
    setState(() {
      _loading = false;
    });
  }

  // ignore: non_constant_identifier_names
  @override
  Widget build(BuildContext context) {
    return isConnectiedToInternet
        ? _loading
            ? Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              )
            : Scaffold(body: insta_Grid_View())
        : noInternet(context);
  }
}
