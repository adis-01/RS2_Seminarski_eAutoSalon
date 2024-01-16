
import 'package:json_annotation/json_annotation.dart';
part 'user_comm.g.dart';

@JsonSerializable()
class KorisnikKomentar{
  String? firstName;
  String? lastName;

  KorisnikKomentar(this.firstName, this.lastName);

  factory KorisnikKomentar.fromJson(Map<String,dynamic> json) => _$KorisnikKomentarFromJson(json);

  Map<String,dynamic> toJson() => _$KorisnikKomentarToJson(this);
}