
import 'package:eautosalon_admin/models/author_news.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class News{
  int? novostiId;
  String? tip;
  String? naslov;
  String? sadrzaj;
  String? slika;
  DateTime? datumObjave;
  KorisnikClanak? korisnik;

  String? get autor{
    return "${korisnik?.firstName} ${korisnik?.lastName}";
  }

  News(this.novostiId, this.tip, this.naslov, this.sadrzaj, this.datumObjave, this.korisnik, this.slika);

  String get date{
    return DateFormat('dd-MM-yyyy').format(datumObjave!);
  }

  factory News.fromJson(Map<String,dynamic> json) => _$NewsFromJson(json);

  Map<String,dynamic> toJson() => _$NewsToJson(this);

}