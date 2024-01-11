
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

  @override
  Automobil fromJson(data) {
    return Automobil.fromJson(data);
  }
}