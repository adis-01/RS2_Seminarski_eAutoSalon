
class News{
  int? novostiId;
  String? tip;
  String? naslov;
  String? sadrzaj;
  String? slika;
  DateTime? datumObjave;
  //KorisnikClanak? korisnik;

  // String? get autor{
  //   return "${korisnik?.firstName} ${korisnik?.lastName}";
  // }

  News(this.novostiId, this.tip, this.naslov, this.sadrzaj, this.datumObjave, this.slika, /*this.korisnik*/);

  // String get date{
  //   return DateFormat('dd-MM-yyyy').format(datumObjave!);
  // }
}