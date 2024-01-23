
class User{
  int? korisnikId;
  String? firstName;
  String? lastName;
  String? email;
  String? slika;
  DateTime? registeredOn;

  User(this.korisnikId, this.firstName,this.lastName,this.email,this.slika, this.registeredOn);

  String? get fullname{
    return "$firstName $lastName";
  }

  String? get registrationDate{
    return registeredOn?.toLocal().toString();
  }

}