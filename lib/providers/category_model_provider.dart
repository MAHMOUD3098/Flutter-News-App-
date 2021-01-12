import 'package:FlutterNewsApp/models/article_model.dart';
import 'package:FlutterNewsApp/services/network_helper.dart';
import 'package:flutter/material.dart';

class CategoryModelProvider extends ChangeNotifier {
  List<ArticleModel> categoryNews = [];
  bool isLoaded = false;
  Future<void> getCategoryNews(String category) async {
    isLoaded = true;
    notifyListeners();
    String apiUrl =
        "http://newsapi.org/v2/top-headlines?country=in&catefory=$category&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=b5bb2f60be85439d867faa403b850031";

    NetworkHelper networkHelper = NetworkHelper(apiUrl);
    var newsData = await networkHelper.getData();

    newsData['articles'].forEach((element) {
      if (element['urlToImage'] != null && element['description'] != null) {
        categoryNews.add(
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
