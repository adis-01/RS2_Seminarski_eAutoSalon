
import 'package:json_annotation/json_annotation.dart';

part 'user_review.g.dart';

@JsonSerializable()
class UserReview{
  String? username;

  UserReview(this.username);

  factory UserReview.fromJson(Map<String,dynamic> json) => _$UserReviewFromJson(json);

  Map<String,dynamic> toJson() => _$UserReviewToJson(this);
}