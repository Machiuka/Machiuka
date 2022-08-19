class UBFUser {
  int? idx;
  String? numeUser;
  String? codUser;
  String?
      nivelUser; //nivel de acces al userului g- gestiune, c-client, f-furnizor (sa nu fac clasa separata pt gestiuni si clienti/furnizori le-am inclus la useri), a-administrator, u - utilizator
  bool? activUser;
  String? adresaUser;
  String? telUser;
  String? emailUser;
  String? functiaUser;
  String? departamUser;
  String? obsUser;

  UBFUser(
      {this.idx,
      this.numeUser,
      this.codUser,
      this.activUser,
      this.nivelUser,
      this.adresaUser,
      this.emailUser,
      this.functiaUser,
      this.telUser,
      this.departamUser,
      this.obsUser});
}
