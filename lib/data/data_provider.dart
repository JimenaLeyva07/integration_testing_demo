import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:integration_testing_demo/models/photo_model.dart';

import '../models/pexel_result_model.dart';

class DataProvider {
  static final DataProvider instance = DataProvider._internal();

  DataProvider._internal();

  factory DataProvider() {
    return instance;
  }

  final String authKey =
      'kZoVspn6yrRGo0ixe15ve7wvW5OfvGXoDtuMGsddbT71x7Yk4vq68YJs';

  final imageSearchUrl = 'https://api.pexels.com/v1/search?query=';

  final curatedImagesUrl = 'https://api.pexels.com/v1/curated?per_page=20';

  StreamController<PexelResultModel> imageSearchStream =
      StreamController.broadcast();

  Future<void> getImagesFromSearchQuery(String searchQuery) async {
    debugPrint("Getting images from search query: $searchQuery");
    http.Response response = await http.get(
        Uri.parse("$imageSearchUrl$searchQuery&per_page=20"),
        headers: {'Authorization': authKey});
    PexelResultModel searchResult =
        PexelResultModel.fromJson(jsonDecode(response.body));

    imageSearchStream.add(searchResult);
  }

  Future<List<PhotoModel>> getCuratedImages() async {
    debugPrint("Getting curated images");
    http.Response response = await http
        .get(Uri.parse(curatedImagesUrl), headers: {'Authorization': authKey});
    List curatedResults = jsonDecode(response.body)['photos'] as List;
    List<PhotoModel> responsePhotos =
        curatedResults.map((e) => PhotoModel.fromJson(e)).toList();
    debugPrint(responsePhotos.toString());
    return responsePhotos;
  }
}
