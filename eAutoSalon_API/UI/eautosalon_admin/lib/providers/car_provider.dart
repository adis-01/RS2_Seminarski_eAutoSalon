
import 'dart:convert';

import 'package:eautosalon_admin/models/car.dart';
import 'package:eautosalon_admin/providers/base_provider.dart';

import '../models/search_result.dart';
import 'package:http/http.dart' as http;

class CarProvider extends BaseProvider<Automobil>{
  CarProvider() : super("Automobil");

  Future<SearchResult<Automobil>> getAktivne(dynamic params) async{
    var filters = getQueryString(params);

    var url = "$baseUrl$endp/Aktivni?$filters";
    var uri = Uri.parse(url);

    var headers = createHeaders();

    var req = await http.get(uri, headers: headers);

    if(isValidResponse(req)){
      SearchResult<Automobil> result = SearchResult<Automobil>();
      var data = jsonDecode(req.body);
      result.hasNext = data['hasNext'];
      result.total = data['totalPages'];
      for (var item in data['list']) {
        result.list.add(fromJson(item));
      }
      return result;
    } 
    else{
      throw Exception("Greška...");
    }
  }

  Future<int> getTotalNumber() async{
    var url = "$baseUrl$endp/TotalNumber";
    var uri = Uri.parse(url);

    var headers=createHeaders();
    var req = await http.get(uri,headers: headers);

    if(isValidResponse(req)){
      int total = 0;
      var data = jsonDecode(req.body);
      total=data;
      return total;
    }
    else{
      throw Exception('Greška...');
    }
  }

  Future<SearchResult<Automobil>> getZavrsene(dynamic params) async{
     var filters = getQueryString(params);

    var url = "$baseUrl$endp/Zavrseni?$filters";
    var uri = Uri.parse(url);

    var headers = createHeaders();

    var req = await http.get(uri, headers: headers);

    if(isValidResponse(req)){
      SearchResult<Automobil> result = SearchResult<Automobil>();
      var data = jsonDecode(req.body);
      result.hasNext = data['hasNext'];
      result.total = data['totalPages'];
      for (var item in data['list']) {
        result.list.add(fromJson(item));
      }
      return result;
    } 
    else{
      throw Exception("Greška...");
    }
  }

  Future<List<String>> getProizvodjace() async{
    var url = "$baseUrl$endp/GetProizvodjace";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var req = await http.get(uri,headers: headers);
    if(isValidResponse(req)){
      List<String> list = [];
      var data = jsonDecode(req.body);
      for (var item in data) {
        list.add(item);
      }
      return list;
    }
    else{
      throw Exception("Greška");
    }
  }

  Future<void> promijeniState(int automobilId) async{
    var url = "$baseUrl$endp/PromijeniStatus/$automobilId";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var req = await http.post(uri,headers: headers);
    if(!isValidResponse(req)){
      throw Exception("Greška...");
    }
  }

  Future<SearchResult<Automobil>> getFiltered(dynamic filters) async{
    var query = getQueryString(filters);

    var url = "$baseUrl$endp/GetFiltered?$query";
    var uri = Uri.parse(url);

    var headers = createHeaders();

    var req = await http.get(uri, headers: headers);
    if(isValidResponse(req)){
      SearchResult<Automobil>? result = SearchResult<Automobil>();
      var data = jsonDecode(req.body);
      result.hasNext=data['hasNext'];
      result.total=data['totalPages'];
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
  Automobil fromJson(data) {
    return Automobil.fromJson(data);
  }
}