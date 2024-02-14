
import 'dart:convert';

import 'package:eautosalon_admin/models/search_result.dart';
import 'package:eautosalon_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class BaseProvider<T> with ChangeNotifier{

  late String _baseUrl;
  late String _endpoint;

  String get baseUrl => _baseUrl;
  String get endp => _endpoint;

  BaseProvider(String endpoint){
    _baseUrl=const String.fromEnvironment("baseUrl", defaultValue: "http://localhost:7173/");
    _endpoint=endpoint;
  } 

  Future<SearchResult<T>> getAll({dynamic filters}) async{
    var url = "$_baseUrl$_endpoint";

    if(filters!=null){
      var queryString = getQueryString(filters);
      url="$url?$queryString";
    }

    var uri = Uri.parse(url);
    var headers = createHeaders();


    var request = await http.get(uri, headers: headers);

    if(isValidResponse(request)){
      var result = SearchResult<T>();
      var data = jsonDecode(request.body);
      for(var item in data['list']){
        result.list.add(fromJson(item));
      }
      return result;
    }
    else{
      throw Exception("Greška...");
    }
  }

  Future<SearchResult<T>> getPaged(dynamic params) async{
    var queryString = getQueryString(params);
    var url = "$_baseUrl$_endpoint?$queryString";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var req = await http.get(uri, headers: headers);
    if(isValidResponse(req)){
      var result = SearchResult<T>();
      var data = jsonDecode(req.body);
      result.hasNext=data['hasNext'];
      result.total = data['totalPages'];
      for (var item in data['list']) {
        result.list.add(fromJson(item));
      }
      return result;
    }
    else{
      throw Exception("Greška");
    }
  }


  Future<T> getById(int id) async{
    var url = "$_baseUrl$_endpoint$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

   

    var request = await http.get(uri, headers: headers);

    if(isValidResponse(request)){
      var data = jsonDecode(request.body);
      return fromJson(data);
    }
    else{
      throw Exception("Greška...");
    }

  }

  Future<T> insert(dynamic object) async{
    var url = "$_baseUrl$_endpoint";
    var uri = Uri.parse(url);
    var headers= createHeaders();

    var obj = jsonEncode(object);
    var request = await http.post(uri, headers: headers, body: obj);

    if(isValidResponse(request)){
      var data = jsonDecode(request.body);
      return fromJson(data);
    }
    else{
      throw Exception("Greška...");
    }
  }

  Future<T> update(int id, dynamic object) async {
    var url = "$_baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var obj = jsonEncode(object);
  
    var request = await http.put(uri, headers: headers, body: obj);

    if(isValidResponse(request)){
      var data = jsonDecode(request.body);
      return fromJson(data);
    }
    else{
      throw Exception("Greška");
    }
  }

  Future<bool> delete(int id) async{
    var url = "$_baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.delete(uri, headers: headers);
    
    if(!isValidResponse(response)){
      throw Exception("Greška...");
    }
    return true;
  }
  
  Map<String,String> createHeaders() {
    String username = Authorization.username ?? "";
    String password = Authorization.password ?? "";

    String auth = "Basic ${base64Encode(utf8.encode('$username:$password'))}";

    var headers = {
      "Content-Type" : "application/json",
      "Authorization" : auth
    };

    return headers;
  }

  bool isValidResponse(Response response){
    if(response.statusCode <= 299){
      return true;
    }
    else if(response.statusCode == 401){
      throw Exception("Pogrešni kredencijali");
    }
    else if(response.statusCode==403){
      throw Exception("Zahtjev odbijen, pristup ograničen");
    }
    else{
      dynamic message = "Nepredviđena greška";
      Map<String,dynamic> error = jsonDecode(response.body);
      if(error.containsKey('errors')){
        message = error['errors']['ERROR'][0];
      }
      throw Exception(message);
    }
  }
  
  T fromJson(data) {
    throw Exception("Not implemented fromJson method");
  }

  String getQueryString(Map params, {bool inRecursion: false}) {
  String query = '';
  params.forEach((key, value) {
    if (inRecursion) {
      if (key is int) {
        key = '[$key]';
      } else if (value is List || value is Map) {
        key = '.$key';
      } else {
        key = '.$key';
      }
    }
    if (value is String || value is int || value is double || value is bool) {
      var encoded = value;
      if (value is String) {
        encoded = Uri.encodeComponent(value);
      }
      if (query.isNotEmpty) {
        query += '&';
      }
      query += '$key=$encoded';
    } else if (value is DateTime) {
      if (query.isNotEmpty) {
        query += '&'; 
      }
      query += '$key=${(value as DateTime).toIso8601String()}';
    } else if (value is List || value is Map) {
      if (value is List) value = value.asMap();
      value.forEach((k, v) {
        query +=
            getQueryString({k: v}, inRecursion: true); 
      });
    }
  });
  return query;
}


 

}