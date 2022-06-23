import 'optiune.dart';

class Global {
  static Optiune optiune = Optiune as Optiune;
  static bool operatie = false; //e nevoie la actualizare factura/aviz este true pentru actualizare
  //static String url = "http://127.0.0.1/serv.php?x={}";
  static String userAccess = 'notOK'; //OK inseamna ca are access userul. NotOK inseamna ca nu are access
  static int durataSesiunii = 60; //durata sesiunii in minute. 60 minute nu mai este intrebat de parola de catre server
  //static String url = 'http://localhost/servPF.php?x={"obj":"pf"}';
  // static String url = 'https://netta.ro/ubf/vanzari/server/';
  static String url = 'http://localhost/server/';
  static String? bazaDate; //tabelul de care avem nevoie
  static String operator = "xxx";
  static String codOperator = "xxx"; //A01...A04
  static String continut = ''; //continutul retetei, facturii, avizului...sub forma '102^2|
  //ultimNumar preia la inceput ultimele numere de pe server pentru fiecare categorie (factura, aviz, etc) pt a avea numere/coduri unice
  static Map<String, int> ultimNumar = {
    'nrFactura': 100,
    'nrAviz': 200,
    'nrProdus': 9900,
    'nrReteta': 9900,
    'nrClient': 1150,
    'nrUser': 1,
    'nrGestiune': 1
  };
  static String element = ''; //este elementul rezultat din interogare server (ex materie prima de adaugat in reteta)
  static Map<String, dynamic>? js; //nefolosit
  static String denumire = '';
  static String cod_doc = '';
  static String cantitate = '';
  static String pret = ''; //este pretul cu TVA pentru a fi actualizat in factura, reteta, aviz
  static String articoleFactura = ''; //este un sir de tip Json
  static String codActivitate = '';
  static String denActivitate = '';
}
