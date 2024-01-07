import 'dart:convert';

import '../models/employee.dart';
import 'base_provider.dart';
import 'package:http/http.dart' as http;

class EmployeeProvider extends BaseProvider<Employee>{

  
  EmployeeProvider() : super("Uposlenici");
  

  Future<void> changePic(int id, dynamic object) async{
    var url = "$baseUrl$endp/ChangePic/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var obj = jsonEncode(object);


    var req = await http.post(uri, headers: headers, body: obj);
    if(!isValidResponse(req)){
      throw Exception("Greška");
    }
  }

  @override
  Employee fromJson(data) {
    return Employee.fromJson(data);
  }

}