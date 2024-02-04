import 'dart:convert';

import 'package:eautosalon_admin/models/report_model.dart';
import 'package:http/http.dart' as http;
import 'package:eautosalon_admin/models/report_dto.dart';
import 'package:eautosalon_admin/providers/base_provider.dart';

class ReportProvider extends BaseProvider<ReportDto>{
  ReportProvider() : super("ZavrseniPoslovi");

  Future<ReportModel> getZavrseni ({dynamic filters}) async{
    var url = "$baseUrl$endp";

    if(filters!=null){
      var queryString = getQueryString(filters);
      url = "$url?$queryString";
    }

    var uri = Uri.parse(url);

    var headers = createHeaders();
    var req = await http.get(uri,headers: headers);

    if(isValidResponse(req)){
      ReportModel reportModel = ReportModel();
      var data = jsonDecode(req.body);
      reportModel.iznos=data['sum'];
      for (var item in data['zavrseni']) {
        reportModel.list.add(fromJson(item));
      }
      return reportModel;
    }
    else{
      throw Exception('Greška...');
    }
  }

  @override
  ReportDto fromJson(data) {
    return ReportDto.fromJson(data);
  }
}