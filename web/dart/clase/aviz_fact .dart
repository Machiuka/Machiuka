import 'dart:convert';
import 'dart:html';
import 'loader.dart';
import 'package:intl/intl.dart';

import '../forms/invoice.dart';

class AvizFact {
  static Future loadAvizFact(String tipDoc, String tabel, String nrFact, String dataAviz) async {
    final DateFormat formatareData = DateFormat('yyyy-M-dd');
    Loader kk = Loader();
    final String dataDoc = formatareData.format(DateTime.now());
    kk
        .aviz2Fact(
            nrAviz: tipDoc,
            numeServer: "serverAviz2Fact",
            optiune: "c",
            tabel: tabel,
            dataDoc: dataDoc,
            codDoc: nrFact.toString(),
            dataAviz: dataAviz)
        .then((rezultat) async {
      //Elimina \ si " din rezultat
      rezultat = rezultat.replaceAll("\\", "");
      rezultat = rezultat.replaceAll('"{', '{');
      rezultat = rezultat.replaceAll('}"', '}');

      final _json = json.decode(rezultat);
      Invoice.afisFactura("fe", _json);
    });
  }
}
