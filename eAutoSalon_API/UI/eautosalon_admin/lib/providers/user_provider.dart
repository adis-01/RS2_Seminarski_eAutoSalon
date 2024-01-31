import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:eautosalon_admin/providers/base_provider.dart';
import '../models/search_result.dart';
import '../models/user.dart';
import '../utils/util.dart';

class UserProvider extends BaseProvider<User> {
  UserProvider() : super("Korisnici");

  Future<User> fetchData() async {
    var url = "$baseUrl$endp/UserProfile?username=${Authorization.username}";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var req = await http.get(uri, headers: headers);
    if (isValidResponse(req)) {
      var obj = jsonDecode(req.body);
      return User.fromJson(obj);
    } else {
      throw Exception("Greška");
    }
  }

  Future<void> changePass(int id, dynamic object) async {
    var url = "$baseUrl$endp/ChangePassword/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var obj = jsonEncode(object);
    var req = await http.post(uri, headers: headers, body: obj);
    if (!isValidResponse(req)) {
      throw Exception("Greška");
    }
  }

  Future<void> changePic(int id, dynamic object) async {
    var url = "$baseUrl$endp/ChangePicture/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var obj = jsonEncode(object);

    var req = await http.post(uri, headers: headers, body: obj);
    if (!isValidResponse(req)) {
      throw Exception("Greška");
    }
  }

    Future<SearchResult<User>> getAktivne(dynamic params) async{
    var filters = getQueryString(params);
    var url = "$baseUrl$endp/GetAktivne?$filters";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    
    var req = await http.get(uri,headers: headers);
    if(isValidResponse(req)){
      SearchResult<User> result = SearchResult<User>();
      var data = jsonDecode(req.body);
      result.hasNext = data['hasNext'];
      result.total = data['totalPages'];
      for (var item in data['list']) {
        result.list.add(fromJson(item));
      }
      return result;
    }
    else{
      throw Exception('Greška');
    }
  }

  Future<void> changeState(int userId) async{
    var url = "$baseUrl$endp/ChangeState/$userId";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    
    var req = await http.put(uri,headers: headers);

    if(!isValidResponse(req)){
      throw Exception('Greška...');
    }
  }

  Future<List<String>> getRoles(String username) async{
    var url = "$baseUrl$endp/GetRoles?username=$username";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    
    var req = await http.get(uri,headers: headers);
    if(isValidResponse(req)){
      List<String> roles = [];
      var data = jsonDecode(req.body);
      for (var item in data) {
        roles.add(item);
      }
      return roles;
    }
    else{
      throw Exception('Greška...');
    }
  }

  Future<int> getTotalNumber() async{
    var url = "$baseUrl$endp/GetTotalNumber";
    var uri = Uri.parse(url);

    var headers = createHeaders();
    var req = await http.get(uri,headers: headers);

    if(isValidResponse(req)){
      int total = 0;
      var data = jsonDecode(req.body);
      total = data;
      return total;
    }
    else{
      throw Exception('Greška...');
    }
  }

  @override
  User fromJson(data) {
    return User.fromJson(data);
  }
}
