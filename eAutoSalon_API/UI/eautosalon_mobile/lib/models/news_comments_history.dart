
import 'package:json_annotation/json_annotation.dart';
part 'news_comments_history.g.dart';

@JsonSerializable()
class ClanakHistorija{
  String? naslov;

  ClanakHistorija(this.naslov);

  factory ClanakHistorija.fromJson(Map<String,dynamic> json) => _$ClanakHistorijaFromJson(json);

  Map<String,dynamic> toJson() => _$ClanakHistorijaToJson(this);
}