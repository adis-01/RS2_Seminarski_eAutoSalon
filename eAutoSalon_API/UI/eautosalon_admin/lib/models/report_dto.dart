
import 'package:eautosalon_admin/models/user_comm.dart';
import 'package:json_annotation/json_annotation.dart';
import 'car_report.dart';

part 'report_dto.g.dart';

@JsonSerializable()
class ReportDto{
  DateTime? datumProdaje;
  double? iznos;
  KorisnikKomentar? korisnik;
  ReportCar? automobil;

  ReportDto(this.datumProdaje,this.iznos,this.korisnik,this.automobil);

  String? get formattedPrice{
    return iznos?.toStringAsFixed(2);
  }

  String? get datum{
    return datumProdaje?.toLocal().toString();
  }

  String? get proizvod{
    return "${automobil?.proizvodjac ?? "null"} ${automobil?.model ?? "null"}";
  }

  String? get kupac{
    return "${korisnik?.firstName ?? "null"} ${korisnik?.lastName ?? "null"}";
  }

  factory ReportDto.fromJson(Map<String,dynamic> json) => _$ReportDtoFromJson(json);

  Map<String,dynamic> toJson() => _$ReportDtoToJson(this);

}