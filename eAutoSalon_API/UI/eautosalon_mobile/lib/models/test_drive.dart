import 'package:eautosalon_mobile/models/car.dart';
import 'package:eautosalon_mobile/models/employee.dart';
import 'package:eautosalon_mobile/models/user.dart';

class TestDrives{
  int? testnaVoznjaId;
  DateTime? datumVrijeme;
  String? status;
  Car? automobil;
  User? korisnik;
  Employee? uposlenik;

  TestDrives(this.testnaVoznjaId, this.datumVrijeme,this.status,this.automobil,this.korisnik,this.uposlenik);

  // String get date{
  //   return DateFormat('dd-MM-yyyy').format(datumVrijeme!);
  // }

  // String get time{
  //   return  DateFormat.Hm().format(datumVrijeme!);
  // }

  String get car{
    return "${automobil?.proizvodjac} ${automobil?.model}";
  }

  String get uposleni{
    return "${uposlenik?.firstName} ${uposlenik?.lastName}";
  }

  String get vozac{
    return "${korisnik?.firstName} ${korisnik?.lastName}";
  }
}