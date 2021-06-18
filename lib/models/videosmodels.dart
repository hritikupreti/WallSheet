class VideoModel {
  User? user;
  Video? url;
  VideoModel({this.url, this.user});

  factory VideoModel.fromMap(Map<String, dynamic> json) {
    return VideoModel(
        user: User.fromMap(json["user"]),
        url: Video.fromMap(json["video_files"]));
  }
}

class User {
  String userName;
  User({required this.userName});

  factory User.fromMap(Map<String, dynamic> json) {
    return User(userName: json["name"]);
  }
}

class Video {
  String link;
  Video({required this.link});
  factory Video.fromMap(List<dynamic> json) {
    return Video(link: json[1]["link"]);
  }
}
