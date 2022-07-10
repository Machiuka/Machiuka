import 'ubf_client.dart';
import 'vanzator_ubf.dart';
import 'vanzator_atp.dart';
import 'global.dart';
import 'local_storage.dart';

class UBFFactura {
  static int? idx;
  static String prefix = 'UBF';
  static int? nrFact;
  static String? dataFact;
  static double totalFactFaraTva = 0.00;
  static double totalFactura = 0.00;
  static double tva9 = 0.00;
  static double tva19 = 0.00;
  static double tva = 0.00;
  static double valDiscount = 0.00;
  static double tvaDiscount = 0.00;
  static int discount = 0;
  static int adaos = 0;
  static int termenPlata = 0;
  static int achitata = 1; //0 pt fact neachitate
  static String operator = Global.operator;
  static String activitate = '';
  static String listaPret = '';
//Sectiunea Vanzator

  Map<String, String> dateVanzator() {
    LocalStorage _local = LocalStorage();
    String _sufix = _local.cauta('sufix').toString();
    if (_sufix == '_atp') {
      return VanzatorATP().dateVanzator();
    } else {
      return VanzatorUBF().dateVanzator();
    }
  }

//sectiunea Cumparator
  static Map<String, dynamic> dateCumparator = UBFClient().toJson();

//Sectiunea date
  static Map<String, dynamic> articol = {
    'codElem': '',
    'denumire': '',
    'unit_mas': 'buc',
    'cantitate': '0',
    'valabilitate': 0,
    'pret': 0,
    'ctva': 9,
    'valoare': 0,
    'tva': 0
  };

  //static Map<String, dynamic> articoleFactura = {"produs": produs, "cantitate": cantitate, "pret": pret, "ctva": ctva};
  static String articoleFactura = ''; //Aici preia articolele in format JSON pt import ulterior in continutura din tbl_facturi

  Map<String, dynamic> toJson() => {
        'idx': idx,
        'cod_doc': nrFact,
        'data_doc': dataFact,
        'total_fara_tva': totalFactFaraTva,
        'date_partener': dateCumparator,
        'total_doc': totalFactura,
        'tva19': tva19,
        'tva9': tva9,
        'total_tva': tva,
        'date_firma': dateVanzator(),
        'adaos': adaos,
        'discount': discount,
        'val_discount': valDiscount,
        'tva_discount': tvaDiscount,
        'termen_plata': termenPlata,
        'achitata': achitata,
        'operator': operator,
        'activitate': activitate,
        'continut': articoleFactura,
        'lista_pret': listaPret
      };
}
