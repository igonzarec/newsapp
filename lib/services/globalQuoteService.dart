import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:news_app/models/globalQuoteModel.dart';

class GlobalQuoteService {
  var dio = Dio();

  String apiKey="RH6AA4HC988Y0BGC";

  GlobalQuoteService(){
    dio.options.baseUrl = "https://www.alphavantage.co";
  }

  Future<GlobalQuoteModel> getGlobalQuote(String symbol) async {
    var endpoint="/query?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$apiKey";
    print(endpoint);
  return await dio.get(endpoint)
      .then((response){
        if(response.data["Note"]!=null) {
          print(response.data["Note"]);
          throw DioError();
        }

         return GlobalQuoteModel.fromJson(response.data["Global Quote"]);
        }).catchError((error)=>print(error));
  }


  Future<List<GlobalQuoteModel>> findGlobalQuotes(String symbol) async{
    print(symbol);
    var endpoint="/query?function=SYMBOL_SEARCH&keywords=$symbol&apikey=$apiKey";
    return await dio.get(endpoint)
        .then((response){
      var results=((response.data["bestMatches"]) as List)
      .map((element)=>GlobalQuoteModel.fromListJson(element)).toList();
      return results;
    }).catchError((error)=>print(error));
    //api is not returning accurate http statuses for errors
  }

}
