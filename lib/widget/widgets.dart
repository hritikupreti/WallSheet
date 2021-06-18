import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pexels_api/helper/chewie.dart';
import 'package:pexels_api/helper/database.dart';
import 'package:pexels_api/views/imageview.dart';
import 'package:pexels_api/views/photos.dart';
import 'package:pexels_api/widget/tostmessage.dart';
import 'package:video_player/video_player.dart';

//
// ignore: non_constant_identifier_names
Widget insta_Grid_View() {
  return StaggeredGridView.countBuilder(
    shrinkWrap: true,
    crossAxisCount: 3,
    itemCount: photomodels.length,
    itemBuilder: (context, index) {
      return GridTile(
        child: PhotoGridTile(
            photographerName: photomodels[index].photographerName,
            url: photomodels[index].src!.portrait),
      );
    },
    staggeredTileBuilder: (index) =>
        StaggeredTile.count((index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),
  );
}

class PhotoGridTile extends StatelessWidget {
  final String url;
  final String? photographerName;
  // ignore: use_key_in_widget_constructors
  const PhotoGridTile({required this.photographerName, required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        Map<String, dynamic> imageDetailMap = {
          "Imageurl": url,
          "autherName": photographerName!,
          "time": DateTime.now().microsecondsSinceEpoch,
        };
        addImageToFav(imageDetailMap);
        showAddToFavMeaasge();
      },
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ImageView(
                      url: url,
                      photographerName: photographerName,
                      fromFav: false,
                    )));
      },
      child: Hero(
        tag: url,
        child: Image.network(
          url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class VideosPlayer extends StatelessWidget {
  final String url;
  final String user;
  final bool fromFav;
  final String? doc;
// ignore: use_key_in_widget_constructors
  const VideosPlayer(
      {required this.url, required this.user, required this.fromFav, this.doc});
  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return GestureDetector(
      onDoubleTap: () {
        Map<String, dynamic> videoDetailMap = {
          "Videourl": url,
          "authorName": user,
          "time": DateTime.now().microsecondsSinceEpoch,
        };
        addVideoToFav(videoDetailMap);
        showAddToFavMeaasge();
      },
      // ignore: sized_box_for_whitespace
      child: fromFav
          ? Stack(
              children: [
                // ignore: sized_box_for_whitespace
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  child: ChewieItems(
                    videoPlayerController: VideoPlayerController.network(url),
                    looping: true,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      deleteVideo(doc!);
                      showRemoveFromFavMessage();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 25),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Icon(
                          Icons.favorite,
                          size: 20,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              // ignore: sized_box_for_whitespace
            )
          : Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              child: ChewieItems(
                videoPlayerController: VideoPlayerController.network(url),
                looping: true,
              ),
            ),
    );
  }
}

Widget noInternet(context) {
  return Center(
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
