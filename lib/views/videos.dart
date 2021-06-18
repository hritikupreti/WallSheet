import 'package:flutter/material.dart';
import 'package:pexels_api/helper/data.dart';
import 'package:pexels_api/models/videosmodels.dart';
import 'package:pexels_api/views/photos.dart';
import 'package:pexels_api/widget/widgets.dart';

// ignore: use_key_in_widget_constructors
class VideosViews extends StatefulWidget {
  @override
  _Videos_ViewsState createState() => _Videos_ViewsState();
}

List<VideoModel> videomodels = <VideoModel>[];

// ignore: camel_case_types
class _Videos_ViewsState extends State<VideosViews> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getVideo();
  }

  getVideo() async {
    VideoData data = VideoData();
    await data.getPhotos();
    videomodels = data.videos!;

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isConnectiedToInternet
        ? _loading
            ? Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              )
            : Scaffold(
                body: ListView.builder(
                    itemCount: videomodels.length,
                    itemBuilder: (context, index) {
                      return VideosPlayer(
                        fromFav: false,
                        url: videomodels[index].url!.link,
                        user: videomodels[index].user!.userName,
                      );
                    }))
        : Center(
            child: Column(
              children: [
                // ignore: sized_box_for_whitespace
                Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset("assets/images/NoInternet.jpg")),
                // ignore: avoid_unnecessary_containers
                const Text("Oops, No Internet")
              ],
            ),
          );
  }
}
