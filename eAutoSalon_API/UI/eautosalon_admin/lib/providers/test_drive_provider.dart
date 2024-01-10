
import 'dart:convert';

import 'package:eautosalon_admin/models/test_drives.dart';
import 'package:eautosalon_admin/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import '../models/search_result.dart';

class TestDriveProvider extends BaseProvider<TestDrives>{
  TestDriveProvider() : super("TestnaVoznja");


  Future<SearchResult<TestDrives>> getActive(dynamic params)async{
    var paged = getQueryString(params);
    var url = "$baseUrl$endp/GetAktivne?$paged";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var req = await http.get(uri, headers: headers);
    if(isValidResponse(req)){
      var result = SearchResult<TestDrives>();
      var data =jsonDecode(req.body);
      result.count = data['pageCount'];
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


  Future<SearchResult<TestDrives>> getFinished(dynamic params) async{
    var paged = getQueryString(params);
    var url = "$baseUrl$endp/GetZavrsene?$paged";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var req = await http.get(uri, headers: headers);
    if(isValidResponse(req)){
      var result = SearchResult<TestDrives>();
      var data =jsonDecode(req.body);
      result.count = data['pageCount'];
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

  Future<void> cancel(int id) async{
    var url = "$baseUrl$endp/Cancel/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var req = await http.put(uri, headers: headers);
    if(!isValidResponse(req)){
      throw Exception("Greška");
    }
  }

   Future<void> complete(int id) async{
    var url = "$baseUrl$endp/Complete/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var req = await http.put(uri, headers: headers);
    if(!isValidResponse(req)){
      throw Exception("Greška");
    }
  }

  @override
  TestDrives fromJson(data) {
    return TestDrives.fromJson(data);
  }
}