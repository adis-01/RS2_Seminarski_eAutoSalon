
import 'package:eautosalon_mobile/models/user_review.dart';
import 'package:json_annotation/json_annotation.dart';
part 'review.g.dart';

@JsonSerializable()
class Review{
  int? recenzijaId;
  int? ocjena;
  String? komentar;
  UserReview? korisnik;

  String? get username{
    return korisnik?.username;
  }

  Review(this.recenzijaId,this.ocjena,this.komentar, this.korisnik);

  factory Review.fromJson(Map<String,dynamic> json) => _$ReviewFromJson(json);

  Map<String,dynamic> toJson() => _$ReviewToJson(this);

}