import 'dart:convert';

import 'package:http/http.dart';

import 'album.dart';

extension APIResponse on Response {
  bool isSuccess() => statusCode == 200;
}

abstract class APIProvider {
  String baseURL = 'https://jsonplaceholder.typicode.com';
  String get apiURL;
  Uri getUrl() => Uri.parse(baseURL + apiURL);

  _fetch() async {
    var response = await get(getUrl());
    if (response.isSuccess()) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}

class AlbumAPIProvider extends APIProvider {
  @override
  String get apiURL => '/albums';
  Future<List<Album>> fetchAlbums() async {
    var listMap = await _fetch() as List;
    return listMap.map((map) => Album.fromMap(map)).toList();
  }
}
