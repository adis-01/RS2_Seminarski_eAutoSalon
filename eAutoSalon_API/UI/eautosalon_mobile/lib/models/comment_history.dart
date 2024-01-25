
import 'package:json_annotation/json_annotation.dart';
import 'news_comments_history.dart';

part 'comment_history.g.dart';


@JsonSerializable()
class KomentarHistorija{
  String? sadrzaj;
  ClanakHistorija? novosti;

  KomentarHistorija(this.sadrzaj, this.novosti);

  String? get naslov{
    return novosti?.naslov;
  }

  factory KomentarHistorija.fromJson(Map<String,dynamic> json) => _$KomentarHistorijaFromJson(json);

  Map<String,dynamic> toJson() => _$KomentarHistorijaToJson(this);

}