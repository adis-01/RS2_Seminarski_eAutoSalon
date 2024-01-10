
import 'package:eautosalon_admin/models/car.dart';
import 'package:eautosalon_admin/models/employee.dart';
import 'package:eautosalon_admin/models/user.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'test_drives.g.dart';

@JsonSerializable()
class TestDrives{
  int? testnaVoznjaId;
  DateTime? datumVrijeme;
  String? status;
  Automobil? automobil;
  User? korisnik;
  Employee? uposlenik;

  TestDrives(this.testnaVoznjaId, this.datumVrijeme,this.status,this.automobil,this.korisnik,this.uposlenik);

  String get date{
    return DateFormat('dd-MM-yyyy').format(datumVrijeme!);
  }

  String get time{
    return  DateFormat.Hm().format(datumVrijeme!);
  }

  String get car{
    return "${automobil?.proizvodjac} ${automobil?.model}";
  }

  String get uposleni{
    return "${uposlenik?.firstName} ${uposlenik?.lastName}";
  }

  String get vozac{
    return "${korisnik?.firstName} ${korisnik?.lastName}";
  }

  factory TestDrives.fromJson(Map<String,dynamic> json) => _$TestDrivesFromJson(json);

  Map<String,dynamic> toJson() => _$TestDrivesToJson(this);
}