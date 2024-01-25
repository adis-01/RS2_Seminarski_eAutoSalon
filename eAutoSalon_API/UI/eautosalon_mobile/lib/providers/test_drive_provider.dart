
import 'dart:convert';

import 'package:eautosalon_mobile/models/test_drive.dart';
import 'package:http/http.dart' as http;
import 'base_provider.dart';

class TestDriveProvider extends BaseProvider<TestDrives>{
  TestDriveProvider() : super("TestnaVoznja");

  Future<List<TestDrives>> getHistory(int korisnikId) async{
    var url = "$baseUrl$endpoint/GetHistory/$korisnikId";
    var uri = Uri.parse(url);

    var headers = createHeaders();
    var req = await http.get(uri,headers: headers);

    if(isValidResponse(req)){
      List<TestDrives> list = [];
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
  TestDrives fromJson(object) {
    return TestDrives.fromJson(object);
  }
}