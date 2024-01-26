import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/car.dart';
import '../models/search_result.dart';
import 'base_provider.dart';

class CarProvider extends BaseProvider<Car>{
  CarProvider() : super("Automobil");

  Future<SearchResult<Car>> getAktivne(dynamic params) async{
    var query = getQueryString(params);
    var url = "$baseUrl$endpoint/Aktivni?$query";
    var uri = Uri.parse(url);

    var headers = createHeaders();
    var req = await http.get(uri,headers: headers);

    if(isValidResponse(req)){
      SearchResult<Car> list = SearchResult<Car>();
      var data = jsonDecode(req.body);
      list.hasNext= data['hasNext'];
      list.totalPages = data['totalPages'];
      for (var item in data['list']) {
        list.list.add(fromJson(item));
      }
      return list;
    }
    else{
      throw Exception('Greška...');
    }
  }

    Future<SearchResult<Car>> getFiltered(dynamic params) async{
    var query = getQueryString(params);
    var url = "$baseUrl$endpoint/GetFiltered?$query";
    var uri = Uri.parse(url);

    var headers = createHeaders();
    var req = await http.get(uri,headers: headers);

    if(isValidResponse(req)){
      SearchResult<Car> list = SearchResult<Car>();
      var data = jsonDecode(req.body);
      list.hasNext= data['hasNext'];
      list.totalPages = data['totalPages'];
      for (var item in data['list']) {
        list.list.add(fromJson(item));
      }
      return list;
    }
    else{
      throw Exception('Greška...');
    }
  }

  Future<List<String>> getProizvodjace() async{
    var url = "$baseUrl$endpoint/GetProizvodjace";
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
      throw Exception('Greška...');
    }

  }

  @override
  Car fromJson(object) {
    return Car.fromJson(object);
  }
}