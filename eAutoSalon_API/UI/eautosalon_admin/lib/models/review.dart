
import 'package:eautosalon_admin/models/user_review.dart';
import 'package:json_annotation/json_annotation.dart';
part 'review.g.dart';

@JsonSerializable()
class Review{
  int? recenzijaId;
  int? ocjena;
  String? komentar;
  String? state;
  UserReview? korisnik;

  Review(this.recenzijaId,this.ocjena,this.komentar,this.korisnik);

  factory Review.fromJson(Map<String,dynamic> json) => _$ReviewFromJson(json);

  Map<String,dynamic> toJson() => _$ReviewToJson(this);
}