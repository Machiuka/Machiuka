class UBFClient {
  static int? idx;
  static int? codElem;
  static String? denumire;
  static String? cui;
  static String? analitic;
  static int adaos = 0;
  static int? discount;
  static String? adresa;
  static String? contBanca;
  static String? banca;
  static String? tel;
  static String? email;
  static String? grupa;
  static String? cif;
  static String? delegat;
  static String? ciNr;
  static String? ciPol;
  static String? masina;
  static String? numeAgent;
  static int? tPlata;
  static String? nrLot; //nr lotului de produse
  static String listaPret = ""; // "" preturi normale, "1" preturi Pitesti, "2" preturi lux, "3" preturi economice, "4" preturi din lista rezerva

  Map<String, dynamic> toJson() => {
        'idx': idx,
        'codElem': codElem,
        'denumire': denumire,
        'cui': cui,
        'analitic': analitic,
        'adaos': adaos,
        'discount': discount,
        'adresa': adresa,
        'contBanca': contBanca,
        'banca': banca,
        'tel': tel,
        'email': email,
        'grupa': grupa,
        'cif': cif,
        'delegat': delegat,
        'ciNr': ciNr,
        'ciPol': ciPol,
        'masina': masina,
        'numeAgent': numeAgent,
        'tPlata': tPlata,
        'nrLot': nrLot,
        'listaPret': listaPret
      };
}
