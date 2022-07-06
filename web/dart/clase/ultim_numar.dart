import 'global.dart';
import 'loader.dart';
import 'dart:convert';
import 'local_storage.dart';
import '../meniuri/meniu.dart';
import '../forms/form_firma.dart';

class UltimNumar {
  static void ultimNumar() async {
    LocalStorage local = LocalStorage();
    String sufix = local.cauta('sufix').toString();

    //  window.alert('Sufix este ' + sufix);
    if (sufix == 'null') {
      //**************Apeleaza Formularul de schimbare firma */
      // sufix e de forma _atp sau _ubf
      FormFirma.formFirma();
    } else {
      Meniu.topMeniu();
      await Future.delayed(const Duration(milliseconds: 50)); //sa apuce sa incarce formularele
      Loader ld = Loader();
      ld.cautaPeServer(criteriu: 'criteriu', tabel: 'tabel', numeServer: 'serverUltimNumar', optiune: sufix).then((value) {
        final _json = json.decode(value);

        Global.ultimNumar['nrFactura'] = double.parse(_json['nrFactura']);
        Global.ultimNumar['nrAviz'] = double.parse(_json['nrAviz']);
        Global.ultimNumar['nrReteta'] = int.parse(_json['nrReteta']);
        Global.ultimNumar['nrClient'] = int.parse(_json['nrClient']);
        Global.ultimNumar['nrProdus'] = int.parse(_json['nrProdus']);
        // Global.ultimNumar['nrUser'] = int.parse(_json['nrUser']);
        //    Global.ultimNumar['nrGestiune'] = int.parse(_json['nrGestiune']);
      });
    }
  }
}
