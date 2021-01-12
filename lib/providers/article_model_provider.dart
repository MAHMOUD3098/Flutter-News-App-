import 'package:FlutterNewsApp/models/article_model.dart';
import 'package:FlutterNewsApp/services/network_helper.dart';
import 'package:flutter/material.dart';

class ArticleModelProvider extends ChangeNotifier {
  List<ArticleModel> news = [];
  bool isLoaded = false;
  Future<void> getNews() async {
    isLoaded = true;
    notifyListeners();
    String apiUrl =
        "http://newsapi.org/v2/everything?domains=wsj.com&apiKey=b5bb2f60be85439d867faa403b850031";

    NetworkHelper networkHelper = NetworkHelper(apiUrl);
    var newsData = await networkHelper.getData();

    newsData['articles'].forEach((element) {
      if (element['urlToImage'] != null && element['description'] != null) {
        news.add(
          new ArticleModel(
            element['author'],
            element['title'],
            element['description'],
            element['url'],
            element['urlToImage'],
            element['content'],
            element['publishedAt'],
          ),
        );
      }
    });
    isLoaded = false;
    notifyListeners();
  }
}
