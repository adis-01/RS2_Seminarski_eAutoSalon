
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'news_author.dart';

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

  News(this.novostiId, this.tip, this.naslov, this.sadrzaj, this.datumObjave, this.slika, this.korisnik);

   String? get autor{
    return "${korisnik?.firstName} ${korisnik?.lastName}";
  }


  String? get datum{
    return datumObjave != null ? DateFormat.yMd().format(datumObjave!) : "date null";
  }

  factory News.fromJson(Map<String,dynamic> json) => _$NewsFromJson(json);

  Map<String,dynamic> toJson() => _$NewsToJson(this);

}