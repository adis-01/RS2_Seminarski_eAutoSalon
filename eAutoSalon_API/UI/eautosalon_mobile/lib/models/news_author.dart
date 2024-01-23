
class KorisnikClanak{
  String? firstName;
  String? lastName;

  KorisnikClanak(this.firstName, this.lastName);

  String? get fullname{
    return "$firstName $lastName";
  }

}