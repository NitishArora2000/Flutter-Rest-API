import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rest_api/newsinfo.dart';

class api {
  Future<Welcome> getNews() async {
    var client = http.Client();
    var newsmodel = null;

    try {
      var response = await client.get(
          'http://newsapi.org/v2/everything?domains=wsj.com&apiKey=6870b768d1394cc981960859c161a6bb');
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        newsmodel = Welcome.fromJson(jsonMap);
      }
    } catch (Exception) {
      return newsmodel;
    }
    return newsmodel;
  }
}
