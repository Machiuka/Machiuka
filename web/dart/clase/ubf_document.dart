import 'global.dart';

class UBFDocument {
  static int? idx;
  static String? dataDoc;
  static String? nrDoc;
  static String emitentDoc = '';
  static String destinatarDoc = '';
  static String? tipDoc; //fi-factura intrare, fe - factura iesire, av - aviz expeditie, rt - reteta
  static String dateEmitentDoc = ''; //si aici la fel
  static String? denumire;
  static String dateDestinatarDoc = ''; //si aici la fel
  static String? obsDoc;
  static String operator = Global.operator; //doar in test am nevoie de el
  static double? pretVanzare;
  static double? pretVanzare1; //Pitesti
  static double? pretVanzare2; //Lux
  static double? pretVanzare3; //Economic
  static double? pretVanzare4; //Rezerva
  static int? cotaTVA;
  static int incasata = 1; //0 pt neincasata
  static int? valabilitate; //pt facturi este termen de plata
  static String? descriere;
  static String? codElem;
  static int? gramaj;
  static String? linkPhoto;
  static String? activitate;
  static String um = "buc.";
  //Sectiunea date
  static Map<String, dynamic> articol = {
    'codElem': '',
    'denumire': '',
    'unit_mas': 'buc',
    'cantitate': '0',
    'valabilitate': 0,
    'pret': 0,
    'valoare': 0,
  };

  static String continutDoc = ''; //Aici preia articolele in format JSON pt import ulterior in continutura din tbl_facturi
  Map toJson() => {
        'idx': idx,
        'dataDoc': dataDoc,
        'denumire': denumire,
        'nrDoc': nrDoc,
        'codElem': codElem,
        'valabilitate': valabilitate,
        'emitentDoc': emitentDoc,
        'destinatarDoc': destinatarDoc,
        'tipDoc': tipDoc,
        'gramaj': gramaj,
        'continutDoc': continutDoc,
        'dateEmitentDoc': dateEmitentDoc,
        'dateDestinatarDoc': dateDestinatarDoc,
        'obs': obsDoc,
        'incasata': incasata,
        'descriere': descriere,
        'pretVanzare': pretVanzare,
        'pretVanzare1': pretVanzare1,
        'pretVanzare2': pretVanzare2,
        'pretVanzare3': pretVanzare3,
        'pretVanzare4': pretVanzare4,
        'cotaTVA': cotaTVA,
        'linkPhoto': linkPhoto,
        'activitate': activitate,
        'operator': operator,
        'um': um
      };
}
