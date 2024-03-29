
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
      dynamic average;
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

  Future<void> hideReview(int reviewId) async{
    var url = "$baseUrl$endp/HideReview/$reviewId";
    var uri = Uri.parse(url);
    
    var headers = createHeaders();
    var req = await http.post(uri,headers: headers);

    if(!isValidResponse(req)){
      throw Exception('Greška...');
    }
  }

  Future<void> showReview(int reviewId) async{
    var url = "$baseUrl$endp/ShowReview/$reviewId";
    var uri = Uri.parse(url);

    var headers = createHeaders();
    var req = await http.post(uri,headers: headers);
    if(!isValidResponse(req)){
      throw Exception('Greška...');
    }
  }



  @override
  Review fromJson(data) {
    return Review.fromJson(data);
  }

}