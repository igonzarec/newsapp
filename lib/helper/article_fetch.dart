import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/article_model.dart';

class ArticleFetch {
  List<ArticleModel> articlesList = [];

  Future<List<ArticleModel>> getTopHeadLines(String country) async {
    String topHeadLinesUrl =
        "http://newsapi.org/v2/top-headlines?country=$country&category=business&apiKey=546da220c68e4439878a1eb013d7dc2d";

    var response = await http.get(topHeadLinesUrl);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach(
        (element) {

          if (element['urlToImage'] != null &&
              element['description'] != null) {
            ArticleModel article = ArticleModel(
              title: element['title'],
              author: element['author'],
              description: element ['description'],
              url: element ['url'],
              urlToImage:  element ['urlToImage'],
              content: element ['content'],
            );
            articlesList.add(article);
          }
        },
      );
      return articlesList;
    } else {
      return articlesList;
    }

  }
}
