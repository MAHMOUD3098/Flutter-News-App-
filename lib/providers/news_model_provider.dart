import 'package:FlutterNewsApp/models/news_model.dart';
import 'package:FlutterNewsApp/services/network_helper.dart';
import 'package:flutter/cupertino.dart';

class NewsModelProvider extends ChangeNotifier {
  List<NewsModel> allNews = [];
  bool isLoaded = false;

  Future<void> getNews({String category}) async {
    allNews.clear();
    isLoaded = true;
    notifyListeners();
    String apiUrl = "";
    if (category == null) {
      apiUrl =
          "http://newsapi.org/v2/everything?domains=wsj.com&apiKey=b5bb2f60be85439d867faa403b850031";
    } else {
      apiUrl =
          "http://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=b5bb2f60be85439d867faa403b850031";
    }
    NetworkHelper networkHelper = NetworkHelper(apiUrl);
    var newsData = await networkHelper.getData();
    newsData['articles'].forEach((element) {
      if (element['urlToImage'] != null && element['description'] != null) {
        allNews.add(
          new NewsModel(
            element['source']['id'],
            element['source']['name'],
            element['author'],
            element['title'],
            element['description'],
            element['url'],
            element['urlToImage'],
            element['publishedAt'],
            element['content'],
          ),
        );
      }
    });
    isLoaded = false;
    notifyListeners();
  }
}
