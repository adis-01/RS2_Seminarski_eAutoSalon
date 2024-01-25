
import 'dart:convert';

import '../models/review.dart';
import 'base_provider.dart';
import 'package:http/http.dart' as http;

class ReviewProvider extends BaseProvider<Review>{

  ReviewProvider() : super("Recenzija");


  Future<double> getAverage() async{
    var url = "$baseUrl$endpoint/Average";
    var uri = Uri.parse(url);

    var headers = createHeaders();

    var req = await http.get(uri,headers: headers);

    if(isValidResponse(req)){
      double average = 0;
      var data = jsonDecode(req.body);
      if(data is int){
        data = data.toDouble();
      }
      average = data;
      return average;
    }
    else{
      throw Exception('Greška...');
    }
  }

  Future<List<Review>> getHistory(int id) async{
    var url = "$baseUrl$endpoint/ByKorisnik/$id";
    var uri = Uri.parse(url);

    var headers = createHeaders();
    var req = await http.get(uri,headers: headers);
    if(isValidResponse(req)){
      List<Review> list = [];
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
  Review fromJson(object) {
    return Review.fromJson(object);
  }
}