import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:eautosalon_admin/providers/base_provider.dart';
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

  @override
  User fromJson(data) {
    return User.fromJson(data);
  }
}
