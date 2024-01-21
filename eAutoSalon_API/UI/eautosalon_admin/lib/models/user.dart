

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
  DateTime? registeredOn;

  String? get registered{
    return registeredOn?.toLocal().toString();
  }

  User(this.korisnikId, this.firstName,this.lastName, this.email, this.slika, this.registeredOn);

  factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);

  Map<String,dynamic> toJson() => _$UserToJson(this);
}


