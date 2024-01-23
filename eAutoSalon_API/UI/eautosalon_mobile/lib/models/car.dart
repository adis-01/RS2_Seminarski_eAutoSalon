
class Car{
  int? automobilId;
  String? brojSasije;
  String? boja;
  int? godinaProizvodnje;
  String? snagaMotora;
  String? vrstaGoriva;
  int? brojVrata;
  int? predjeniKilometri;
  String? proizvodjac;
  String? model;
  String? slika;
  double? cijena;

  Car(
      this.automobilId,
      this.brojSasije,
      this.boja,
      this.godinaProizvodnje,
      this.snagaMotora,
      this.vrstaGoriva,
      this.brojVrata,
      this.predjeniKilometri,
      this.proizvodjac,
      this.model,
      this.slika,
      this.cijena
  );

  //String get formattedPrice { return NumberFormat.currency(locale: 'en_US', symbol: '').format(cijena);}

}