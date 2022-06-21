import 'dart:html';
import '../clase/load_detalii.dart';
import 'administrare_meniu.dart';
import 'rapoarte_meniu.dart';
import 'formular_meniu.dart';
import 'livrare_meniu.dart';

import '../clase/login.dart';
import '../clase/local_storage.dart';
import '../forms/form_firma.dart';

//Aici este actiunea cand se face click pe meniurile din meniu_nav.dart
class Meniu {
  static void topMeniu() async {
    LocalStorage local = LocalStorage();
    String sufix = '';
    String activitate = '';
    sufix = local.cauta('sufix').toString();
    activitate = local.cauta('activitate').toString();
    LoadDetalii.incarcFormular('html/top_nav.html');
    await Future.delayed(const Duration(milliseconds: 50));

    Element _btnLivrare = querySelector('#btnLivrare') as Element;
    Element _btnRetetar = querySelector('#btnRetetar') as Element;
    Element _btnRapoarte = querySelector('#btnRapoarte') as Element;
    Element _btnFirma = querySelector('#btnFirma') as Element;
    Element _btnAdministrare = querySelector('#btnAdministrare') as Element;
    Element _btnExit = querySelector('#btnExit') as Element;
    if (sufix == "_ubf") {
      _btnFirma.innerHtml = "UBF" + " " + activitate;
    } else {
      _btnFirma.innerHtml = "ATP" + " " + activitate;
    }
    _btnLivrare.onClick.listen((e) {
      LivrareMeniu.livrareMeniu();
    });

    _btnRetetar.onClick.listen((e) {
      FormularMeniu.formularMeniu('RETETAR');
      //  Global.optiune = Optiune.rd;
    });

    _btnRapoarte.onClick.listen((e) {
      RapoarteMeniu.rapoarteMeniu();
    });
    _btnFirma.onClick.listen((e) {
      FormFirma.formFirma();

      //SvgFile.svgFile();
    });

    _btnAdministrare.onClick.listen((e) {
      AdministrareMeniu.administrareMeniu();
    });

    _btnExit.onClick.listen((e) {
      Login logOut = Login();
      logOut.logOut();
    });
  }
}
