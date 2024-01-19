
import 'dart:convert';

import 'package:eautosalon_admin/models/review.dart';
import 'package:eautosalon_admin/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class ReviewProvider extends BaseProvider<Review>{
  ReviewProvider() : super("Recenzija");


  Future<double> getAverage() async{
    var url = "$baseUrl$endp/Average";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var req = await http.get(uri, headers: headers);
    if(isValidResponse(req)){
      double average;
      var data = jsonDecode(req.body);
      average = data;
      return average;
    }
    else{
      throw Exception('Greška...');
    }
  }

  @override
  Review fromJson(data) {
    return Review.fromJson(data);
  }

}