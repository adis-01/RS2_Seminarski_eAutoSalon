
import 'dart:convert';

import 'package:eautosalon_mobile/models/news.dart';
import 'package:eautosalon_mobile/models/search_result.dart';
import 'base_provider.dart';
import 'package:http/http.dart' as http;
class NewsProvider extends BaseProvider<News>{

  NewsProvider() : super("Novosti");

  Future<SearchResult<News>> getSve(dynamic params) async{
    var queryString = getQueryString(params);
    var url = "$baseUrl$endpoint/getSve?$queryString";
    var uri = Uri.parse(url);

    var headers = createHeaders();
    var req = await http.get(uri,headers: headers);
    if(isValidResponse(req)){
      SearchResult<News> result = SearchResult<News>();
      var data = jsonDecode(req.body);
      result.hasNext = data['hasNext'];
      result.totalPages=data['totalPages'];
      for (var item in data['list']) {
        result.list.add(fromJson(item));
      }
      return result;
    }
    else{
      throw Exception('Greška...');
    }

  }


  @override
  News fromJson(object) {
    return News.fromJson(object);
  }
}