
import 'dart:convert';

import 'package:eautosalon_mobile/models/search_result.dart';
import 'package:eautosalon_mobile/providers/base_provider.dart';

import '../models/employee.dart';
import 'package:http/http.dart' as http;

class EmployeeProvider extends BaseProvider<Employee>{
  
  EmployeeProvider() : super("Uposlenici");

  Future<SearchResult<Employee>> getAktivne() async{

    var url = "$baseUrl$endpoint/GetAktivne";
    var uri = Uri.parse(url);

    var headers = createHeaders();
    var req = await http.get(uri,headers: headers);

    if(isValidResponse(req)){
      SearchResult<Employee> result = SearchResult<Employee>();
      var data = jsonDecode(req.body);
      result.hasNext = data['hasNext'];
      result.totalPages = data['totalPages'];
      for (var item in data['list']) {
        result.list.add(fromJson(item));
      }
      return result;
    }
    else{
      throw Exception('Greška...');
    }
  }

  @override
  Employee fromJson(object) {
    return Employee.fromJson(object);
  }
}