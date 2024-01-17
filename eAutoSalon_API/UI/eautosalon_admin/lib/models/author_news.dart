
import 'package:json_annotation/json_annotation.dart';

part 'author_news.g.dart';

@JsonSerializable()
class KorisnikClanak{
  String? firstName;
  String? lastName;

  KorisnikClanak(this.firstName, this.lastName);

  factory KorisnikClanak.fromJson(Map<String,dynamic> json) => _$KorisnikClanakFromJson(json);

  Map<String,dynamic> toJson() => _$KorisnikClanakToJson(this);
}