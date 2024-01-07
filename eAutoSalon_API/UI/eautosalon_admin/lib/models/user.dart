
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User{
  int? korisnikId;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? slika;

  User(this.korisnikId, this.firstName,this.lastName, this.email, this.slika);

  factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);

  Map<String,dynamic> toJson() => _$UserToJson(this);
}


