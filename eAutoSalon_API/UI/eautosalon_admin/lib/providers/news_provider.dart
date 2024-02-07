import 'dart:convert';

import 'package:eautosalon_admin/models/news.dart';
import 'package:eautosalon_admin/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import '../models/search_result.dart';

class NewsProvider extends BaseProvider<News> {
  NewsProvider() : super("Novosti");


  Future<SearchResult<News>> getSve(dynamic filters) async{
    var queryString = getQueryString(filters);
    var url = "$baseUrl$endp/getSve?$queryString";
    var uri = Uri.parse(url);
    
    var headers=createHeaders();
    var req = await http.get(uri,headers: headers);

    if(isValidResponse(req)){
      SearchResult<News> result = SearchResult<News>();
      var data = jsonDecode(req.body);
      result.hasNext = data['hasNext'];
      result.total = data['totalPages'];
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
  News fromJson(data) {
    return News.fromJson(data);
  }
}
