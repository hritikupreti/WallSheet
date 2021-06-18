//to store only  usefull data from json data
class PhotoModels {
  final String? photographerName;
  SrcModel? src;
  PhotoModels({this.photographerName, this.src});

  factory PhotoModels.fromMap(Map<String, dynamic> jsonData) {
    return PhotoModels(
        photographerName: jsonData["photographer"],
        src: SrcModel.fromMap(jsonData["src"]));
  }
}

//SrcModel itself a list so inorder to fatch data from it its neccessary to make class of ScrModel type
class SrcModel {
  String portrait;
  SrcModel({required this.portrait});

  factory SrcModel.fromMap(Map<String, dynamic> jsonData) {
    return SrcModel(portrait: jsonData["portrait"]);
  }
}
