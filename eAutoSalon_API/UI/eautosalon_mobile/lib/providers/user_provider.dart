
import 'dart:convert';

import 'package:eautosalon_mobile/providers/base_provider.dart';
import 'package:eautosalon_mobile/utils/helpers.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserProvider extends BaseProvider<User>{

  UserProvider() : super("Korisnici");

  Future<User> fetchUserProfile() async{
    var url = "$baseUrl$endpoint/UserProfile?username=${Authorization.username}";
    var uri = Uri.parse(url);

    var headers = createHeaders();

    var req = await http.get(uri,headers: headers);
    if(isValidResponse(req)){
      var data = jsonDecode(req.body);
      return User.fromJson(data);
    }
    else{
      throw Exception('Greška...');
    }
  }

  Future<void> changePass(int korisnikId, dynamic object) async{
    var url = "$baseUrl$endpoint/ChangePassword/$korisnikId";
    var uri = Uri.parse(url);

    var obj = jsonEncode(object);

    var headers = createHeaders();
    var req = await http.post(uri,headers: headers,body: obj);

    if(!isValidResponse(req)){
      throw Exception('Greška...');
    }
  }

  Future<int> getUserId() async{
    var url = "$baseUrl$endpoint/getUserId?username=${Authorization.username}";
    var uri = Uri.parse(url);

    var headers = createHeaders();
    var req = await http.get(uri,headers: headers);
    if(isValidResponse(req)){
      int id = 0;
      var data = jsonDecode(req.body);
      id = data;
      return id;
    }
    else{
      throw Exception('Greška...');
    }
  }

  Future<void> verify(dynamic request) async{
    var url = "$baseUrl$endpoint/Verify";
    var uri = Uri.parse(url);
    
    var obj = jsonEncode(request);
    var headers = {
      'Content-Type' : 'application/json'
    };

    var req = await http.post(uri, body: obj, headers: headers);
    if(!isValidResponse(req)){
      throw Exception('Greška...');
    }
  }

  @override
  User fromJson(object) {
    return User.fromJson(object);
  }

}