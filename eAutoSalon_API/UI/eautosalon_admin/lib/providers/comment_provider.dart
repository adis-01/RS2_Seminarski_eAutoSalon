
import 'dart:convert';

import 'package:eautosalon_admin/models/comment.dart';
import 'package:eautosalon_admin/models/search_result.dart';
import 'package:eautosalon_admin/providers/base_provider.dart';
import 'package:http/http.dart' as http;

import '../utils/util.dart';

class KomentarProvider extends BaseProvider<Comment>{
  KomentarProvider() : super("Komentari");

  Future<SearchResult<Comment>> komentarNovost(int novostId, dynamic params) async{
    var pagination = getQueryString(params);
    var url = "$baseUrl$endp/Komentari_Novost/$novostId?$pagination";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var req = await http.get(uri, headers: headers);

    if(isValidResponse(req)){
      SearchResult<Comment> result = SearchResult<Comment>();
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

  Future<int> getTotalComms(int novostId) async{
    var url = "$baseUrl$endp/TotalNumber/$novostId";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var req = await http.get(uri,headers: headers);
    if(isValidResponse(req)){
      int count;
      var data = jsonDecode(req.body);
      count = data;
      return count;
    }
    else{
      throw Exception('Greška...');
    }
  }

    Future<int> getUserId() async{
    String username = Authorization.username ?? "";
    var url = "${baseUrl}Novosti/userID?username=$username";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var req = await http.get(uri, headers: headers);
    if(isValidResponse(req)){
      var data = jsonDecode(req.body);
      int id = data;
      return id;
    }
    else{
      throw Exception('Greška...');
    }
  }

  Future<void> hideComment(int komentarId) async{
    var url = "$baseUrl$endp/HideComment/$komentarId";
    var uri = Uri.parse(url);
    
    var headers = createHeaders();
    var req = await http.post(uri,headers: headers);
    if(!isValidResponse(req)) { throw Exception('Greška...'); }
  }

  @override
  Comment fromJson(data) {
    return Comment.fromJson(data);
  }
}