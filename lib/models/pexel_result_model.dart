import 'photo_model.dart';

class PexelResultModel {
  PexelResultModel({
    required this.page,
    required this.perPage,
    required this.photos,
    required this.nextPage,
  });

  final int page;
  final int perPage;
  final List<PhotoModel> photos;
  final String nextPage;

  PexelResultModel copyWith({
    int? page,
    perPage,
    List<PhotoModel>? photos,
    String? nextPage,
  }) =>
      PexelResultModel(
        page: page ?? this.page,
        perPage: perPage ?? this.perPage,
        photos: photos ?? this.photos,
        nextPage: nextPage ?? this.nextPage,
      );

  factory PexelResultModel.fromJson(Map<String, dynamic> json) =>
      PexelResultModel(
        page: json["page"],
        perPage: json["per_page"],
        photos: List<PhotoModel>.from(
            json["photos"].map((x) => PhotoModel.fromJson(x))),
        nextPage: json["next_page"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
        "next_page": nextPage,
      };
}
