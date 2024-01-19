import 'dart:convert';

import '../models/employee.dart';
import '../models/search_result.dart';
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

  Future<SearchResult<Employee>> getAktivne() async{
    var url = "$baseUrl$endp/GetAktivne";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    
    var req = await http.get(uri,headers: headers);
    if(isValidResponse(req)){
      SearchResult<Employee> result = SearchResult<Employee>();
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

  Future<void> changeState(int employeeId) async{
    var url = "$baseUrl$endp/ChangeState/$employeeId";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    
    var req = await http.put(uri,headers: headers);

    if(!isValidResponse(req)){
      throw Exception('Greška...');
    }
  }

  @override
  Employee fromJson(data) {
    return Employee.fromJson(data);
  }

}