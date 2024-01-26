
import 'package:json_annotation/json_annotation.dart';
part 'news_author.g.dart';

@JsonSerializable()
class KorisnikClanak{
  String? firstName;
  String? lastName;

  KorisnikClanak(this.firstName, this.lastName);

  String? get fullname{
    return "$firstName $lastName";
  }

    factory KorisnikClanak.fromJson(Map<String,dynamic> json) => _$KorisnikClanakFromJson(json);

    Map<String,dynamic> toJson() => _$KorisnikClanakToJson(this);

}