import 'optiune.dart';
import 'dart:html';

class Global {
  static Optiune optiune = Optiune as Optiune;
  static bool operatie = false; //e nevoie la actualizare factura/aviz este true pentru actualizare
  //static String url = "http://127.0.0.1/serv.php?x={}";
  static String userAccess = 'notOK'; //OK inseamna ca are access userul. NotOK inseamna ca nu are access
  static int durataSesiunii = 600; //durata sesiunii in minute. 60 minute nu mai este intrebat de parola de catre server
  //static String url = 'http://localhost/servPF.php?x={"obj":"pf"}';
  // static String url = 'https://netta.ro/ubf/vanzari/server/';

  //static String url = 'http://localhost/server/';
  static String? bazaDate; //tabelul de care avem nevoie
  static String operator = "xxx";
  static int precision = 100; //ajuta la eliminarea erorilor de rotunjire
  static double zecimale = 0.1; //rotunjire la total factura
  static String codOperator = "xxx"; //A01...A04
  static String continut = ''; //continutul retetei, facturii, avizului...sub forma '102^2|
  static String url = _url();
//  static String url = "http://localhost/server/";

  //ultimNumar preia la inceput ultimele numere de pe server pentru fiecare categorie (factura, aviz, etc) pt a avea numere/coduri unice

  static Map<String, num> ultimNumar = {
    'nrFactura': 100,
    'nrAviz': 200,
    'nrNir': 100,
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
  static String um = ''; //unitate de masura a produsului, mat prime
  static String cantitate = '';
  static String pret = ''; //este pretul cu TVA pentru a fi actualizat in factura, reteta, aviz
  static String articoleFactura = ''; //este un sir de tip Json
  static String codActivitate = '';
  static String denActivitate = '';
  static String _url() {
    //Permite utilizarea aplicatiei de pe orice calculator din reteaua locala. Se introduce IP-ul calculatorului unde este instalata in fisierul index.html
    Element _adresa = querySelector("#ipAddress") as Element;
    String _ip = "";
    _ip = "http://" + _adresa.innerHtml.toString() + "/server/";

    return _ip;
  }
}
