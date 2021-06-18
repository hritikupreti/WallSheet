import 'package:cloud_firestore/cloud_firestore.dart';

//add image to firebase database
addImageToFav(userMap) async {
  await FirebaseFirestore.instance.collection("photos").add(userMap);
}

//add video to firebase database
addVideoToFav(userMap) async {
  await FirebaseFirestore.instance.collection("videos").add(userMap);
}

//to get favourite images from database
getImages() async {
  // ignore: await_only_futures
  return await FirebaseFirestore.instance
      .collection("photos")
      .orderBy("time", descending: true)
      .snapshots();
}

//to get favourite videos from database
getVideos() async {
  // ignore: await_only_futures
  return await FirebaseFirestore.instance
      .collection("videos")
      .orderBy("time", descending: true)
      .snapshots();
}

//to unfavourite image by deleting it from database
delete(String doc) async {
  await FirebaseFirestore.instance.collection("photos").doc(doc).delete();
}

//to unfavourite videos by deleting it from database
deleteVideo(String doc) async {
  await FirebaseFirestore.instance.collection("videos").doc(doc).delete();
}
