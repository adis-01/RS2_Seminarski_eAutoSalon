
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class News{
  int? novostiId;
  String? tip;
  String? naslov;
  String? sadrzaj;
  DateTime? datumObjave;

  News(this.novostiId, this.tip, this.naslov, this.sadrzaj, this.datumObjave);

  String get date{
    return DateFormat('dd-MM-yyyy').format(datumObjave!);
  }

  factory News.fromJson(Map<String,dynamic> json) => _$NewsFromJson(json);

  Map<String,dynamic> toJson() => _$NewsToJson(this);

}