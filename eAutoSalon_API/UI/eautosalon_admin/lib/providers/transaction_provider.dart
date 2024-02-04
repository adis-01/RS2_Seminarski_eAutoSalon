import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:eautosalon_admin/models/transactions.dart';
import 'package:eautosalon_admin/providers/base_provider.dart';

class TransakcijaProvider extends BaseProvider<Transakcija>{

  TransakcijaProvider() : super("Transakcije");


  Future<List<Transakcija>> getTransakcije() async{
    var url = "$baseUrl$endp";
    var uri = Uri.parse(url);

    var headers = createHeaders();
    var req = await http.get(uri,headers: headers);

    if(isValidResponse(req)){
      List<Transakcija> list = [];
      var data = jsonDecode(req.body);
      for (var item in data) {
        list.add(fromJson(item));
      }
      return list;
    }
    else{
      throw Exception('Greška...');
    }
  }

  @override
  Transakcija fromJson(data) {
    return Transakcija.fromJson(data);
  }
}