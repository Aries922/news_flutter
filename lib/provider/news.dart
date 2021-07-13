import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:news_flutter/models/newsmodel.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NewsProvider with ChangeNotifier {

  NewsData? _newsData = NewsData(data: []);

  NewsData get newsList {
    return _newsData!;
  }

  set newsList(NewsData news) {
    this._newsData = news;
    notifyListeners();
  }

  Future<NewsData> getListNewsOnline() async {
    var url = Uri.parse("https://api.first.org/data/v1/news");
    print("News List API init");
    print(url);
    try {
      final response = await http.get(url);


      
      newsList = NewsData.fromJson(json.decode(response.body));
      print("hello"+"${_newsData?.total}");
      print(_newsData?.data?.length);
      
    } catch (e) {
      print(e.toString());
    }
    return _newsData!;
  }
}
