import 'dart:convert';

import 'package:eautosalon_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class ContactProvider extends BaseProvider<dynamic>{

  ContactProvider() : super("Contact");

  Future<void> sendMail(dynamic request) async {
    var url = "$baseUrl$endpoint/ContactPage";
    var uri = Uri.parse(url);
    
    var headers = createHeaders();
    var obj = jsonEncode(request);

    var req = await http.post(uri,headers: headers, body: obj);

    if(!isValidResponse(req)){
      throw Exception('Greška....');
    }
  }
}
