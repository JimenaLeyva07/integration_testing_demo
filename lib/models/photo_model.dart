import 'src_model.dart';

class PhotoModel {
  PhotoModel({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
    required this.photographer,
    required this.photographerUrl,
    required this.photographerId,
    required this.avgColor,
    required this.src,
    required this.liked,
    required this.alt,
  });

  final int id;
  final int width;
  final int height;
  final String url;
  final String photographer;
  final String photographerUrl;
  final int photographerId;
  final String avgColor;
  final SrcModel src;
  final bool liked;
  final String alt;

  PhotoModel copyWith({
    int? id,
    width,
    height,
    photographerId,
    String? url,
    photographer,
    photographerUrl,
    avgColor,
    alt,
    SrcModel? src,
    bool? liked,
  }) =>
      PhotoModel(
        id: id ?? this.id,
        width: width ?? this.width,
        height: height ?? this.height,
        url: url ?? this.url,
        photographer: photographer ?? this.photographer,
        photographerUrl: photographerUrl ?? this.photographerUrl,
        photographerId: photographerId ?? this.photographerId,
        avgColor: avgColor ?? this.avgColor,
        src: src ?? this.src,
        liked: liked ?? this.liked,
        alt: alt ?? this.alt,
      );

  factory PhotoModel.fromJson(Map<String, dynamic> json) => PhotoModel(
        id: json["id"],
        width: json["width"],
        height: json["height"],
        url: json["url"],
        photographer: json["photographer"],
        photographerUrl: json["photographer_url"],
        photographerId: json["photographer_id"],
        avgColor: json["avg_color"],
        src: SrcModel.fromJson(json["src"]),
        liked: json["liked"],
        alt: json["alt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "width": width,
        "height": height,
        "url": url,
        "photographer": photographer,
        "photographer_url": photographerUrl,
        "photographer_id": photographerId,
        "avg_color": avgColor,
        "src": src.toJson(),
        "liked": liked,
        "alt": alt,
      };
}
