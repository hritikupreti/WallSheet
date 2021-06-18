// ignore: import_of_legacy_library_into_null_safe
import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;
import 'package:pexels_api/models/photomodel.dart';
import 'package:pexels_api/models/videosmodels.dart';

class PhotoData {
  List<PhotoModels>? photos = [];
  // ignore: prefer_typing_uninitialized_variables
  var response;

//To fetch photos from pexel's api
  Future<void> getPhotos() async {
    var uriResponse =
        Uri.parse("https://api.pexels.com/v1/curated?per_page=80");
    var apiKey = "563492ad6f917000010000014b1e9afaaaf74b6ca10953a7bda21f66";
    response = await http.get(uriResponse, headers: {"Authorization": apiKey});
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      PhotoModels photomodel = PhotoModels();
      photomodel = PhotoModels.fromMap(element);
      photos!.add(photomodel);
    });
  }
}

//To fetch videos from pexel's api
class VideoData {
  List<VideoModel>? videos = [];
  Future<void> getPhotos() async {
    var uriResponse =
        Uri.parse("https://api.pexels.com/videos/popular?per_page=5");
    var apiKey = "563492ad6f917000010000014b1e9afaaaf74b6ca10953a7bda21f66";
    var response =
        await http.get(uriResponse, headers: {"Authorization": apiKey});

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["videos"].forEach((element) {
      VideoModel videomodel = VideoModel();
      videomodel = VideoModel.fromMap(element);
      videos!.add(videomodel);
    });
  }
}
