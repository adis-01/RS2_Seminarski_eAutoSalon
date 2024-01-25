
import 'package:eautosalon_mobile/models/user_comm.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment{
  int? komentarId;
  String? sadrzaj;
  KorisnikKomentar? korisnik;

  Comment(this.komentarId, this.sadrzaj, this.korisnik);

  String? get komKorisnik{
    return "${korisnik?.firstName} ${korisnik?.lastName}";
  }

  factory Comment.fromJson(Map<String,dynamic> json) => _$CommentFromJson(json);

  Map<String,dynamic> toJson() => _$CommentToJson(this);
}