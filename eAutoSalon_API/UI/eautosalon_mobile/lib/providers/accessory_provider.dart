
import 'dart:convert';

import 'package:eautosalon_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import '../models/accessory.dart';

class OpremaProvider extends BaseProvider<DodatnaOprema>{
  OpremaProvider() : super("Oprema");


  Future<DodatnaOprema> getOprema(int automobilId) async{
    var url = "$baseUrl$endpoint/$automobilId";
    var uri = Uri.parse(url);

    var headers = createHeaders();
    var req = await http.get(uri,headers: headers);

    if(isValidResponse(req)){
      var data = jsonDecode(req.body);
      return DodatnaOprema.fromJson(data);
    }
    else{
      throw Exception('Greška...');
    }
  }

  @override
  DodatnaOprema fromJson(object) {
    return DodatnaOprema.fromJson(object);
  }
}