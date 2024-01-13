
import 'dart:convert';

import '../models/car_accesories.dart';
import 'base_provider.dart';
import 'package:http/http.dart' as http;

class DodatnaOpremaProvider extends BaseProvider<DodatnaOprema>{
  DodatnaOpremaProvider() : super("Oprema");

  Future<DodatnaOprema> getOprema(int automobilId) async{
    var url = "$baseUrl$endp/$automobilId";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var req = await http.get(uri, headers: headers);
    if(isValidResponse(req)){
      var data = jsonDecode(req.body);
      return fromJson(data);
    }
    else{
      throw Exception('Greška...');
    }
  }



  @override
  DodatnaOprema fromJson(data) {
    return DodatnaOprema.fromJson(data);
  }
} 