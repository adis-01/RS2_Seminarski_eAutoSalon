
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User{
  int? korisnikId;
  String? firstName;
  String? lastName;
  String? email;
  String? slika;
  DateTime? registeredOn;

  User(this.korisnikId, this.firstName,this.lastName,this.email,this.slika, this.registeredOn);


  String? get fullname{
    return "$firstName $lastName";
  }


  String? get registrationDate{
    return registeredOn != null ? DateFormat.yMMMd().format(registeredOn!) : "date null";
  }

  factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);

  Map<String,dynamic> toJson() => _$UserToJson(this);

}