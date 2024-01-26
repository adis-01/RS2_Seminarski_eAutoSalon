
import 'dart:convert';

import 'package:eautosalon_mobile/models/comment.dart';
import 'package:eautosalon_mobile/models/comment_history.dart';
import 'package:eautosalon_mobile/models/search_result.dart';
import 'package:eautosalon_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class KomentarProvider extends BaseProvider<Comment>{

  KomentarProvider() : super("Komentari");


  Future<int> totalNumber(int id) async{
    var url = "$baseUrl$endpoint/TotalNumber/$id";
    var uri = Uri.parse(url);

    var headers = createHeaders();
    var req = await http.get(uri,headers: headers);
    
    if(isValidResponse(req)){
      int number = 0;
      var data = jsonDecode(req.body);
      number = data;
      return number;
    }
    else{
      throw Exception('Greška...');
    }
  }

  Future<SearchResult<Comment>> getKomentare(int novostId, dynamic params) async{
    var queryString = getQueryString(params);
    var url = "$baseUrl$endpoint/Komentari_Novost/$novostId?$queryString";
    var uri = Uri.parse(url);

    var headers = createHeaders();
    var req = await http.get(uri,headers: headers);

    if(isValidResponse(req)){
      SearchResult<Comment> result = SearchResult<Comment>();
      var data = jsonDecode(req.body);
      result.hasNext = data['hasNext'];
      result.totalPages = data['totalPages'];
      for (var item in data['list']) {
        result.list.add(fromJson(item));
      }
      return result;
    }
    else{
      throw Exception('Greška...');
    }
  }


  Future<List<KomentarHistorija>> getHistory (int korisnikId) async{
    var url = "$baseUrl$endpoint/History/$korisnikId";
    var uri = Uri.parse(url);

    var headers = createHeaders();
    var req = await http.get(uri,headers: headers);

    if(isValidResponse(req)){
      List<KomentarHistorija> list = [];
      var data = jsonDecode(req.body);
      for (var item in data) {
        list.add(KomentarHistorija.fromJson(item));
      }
      return list;
    }
    else{
      throw Exception('Greška...');
    }
  }


  @override
  Comment fromJson(object) {
    return Comment.fromJson(object);
  }

}