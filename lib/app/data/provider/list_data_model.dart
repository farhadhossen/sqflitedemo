// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ChannelListModel channelListModelFromJson(String str) => ChannelListModel.fromJson(json.decode(str));

String channelListModelToJson(ChannelListModel data) => json.encode(data.toJson());

class ChannelListModel {
  ChannelListModel({
    this.data,
  });

  List<Datum>? data;

  factory ChannelListModel.fromJson(Map<String, dynamic> json) => ChannelListModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.imageUrl,
    this.stramUrl,
    this.chName,
    this.description,
    this.viewing,
    this.isFav,
  });

  int? id;
  String? imageUrl;
  String? stramUrl;
  String? chName;
  String? description;
  String? viewing;
  int? isFav;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id : json["id"],
    imageUrl: json["imageUrl"],
    stramUrl: json["stramUrl"],
    chName: json["ch_name"],
    description: json["description"],
    viewing: json["viewing"],
    isFav: json["isFav"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "imageUrl": imageUrl,
    "stramUrl": stramUrl,
    "chName": chName,
    "description": description,
    "viewing": viewing,
    "isFav": isFav,
  };

  Datum copy({
    int? id,
    String? imageUrl,
    String? stramUrl,
    String? chName,
    String? description,
    String? viewing,
    int? isFav,
})=>Datum(
    id: id?? this.id,
    imageUrl: imageUrl?? this.imageUrl,
    stramUrl: stramUrl?? this.stramUrl,
    chName: chName?? this.chName,
    description: description?? this.description,
    viewing: viewing?? this.viewing,
    isFav: isFav?? this.isFav,
  );

}

///for database
final String tableFavorites = "favorites";
class FavoriteFields{

  static final List<String> values = [
    ///all fields name
    id, imageUrl, stramUrl, chName, description, viewing, isFav
  ];
  static final String id = 'id';
  static final String imageUrl = "imageUrl";
  static final String stramUrl = "stramUrl";
  static final String chName = "chName";
  static final String description = "description";
  static final String viewing = "viewing";
  static final String isFav = "isFav";
}
