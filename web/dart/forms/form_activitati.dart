import 'dart:html';
import 'dart:convert';
import '../clase/load_detalii.dart';
import '../clase/loader.dart';
import '../clase/local_storage.dart';
import '../clase/global.dart';

class FormActivitati {
  static void formActivitati() async {
    String formular = 'html/form_activitati.html';
    String _activitate = '';
    String sufix = "";
    String tabel = "tbl_activitati";
    FormElement _formFirma = querySelector("#formFirma") as FormElement;
    Loader loader = Loader();
    LocalStorage local = LocalStorage();
    LoadDetalii.incarcFormular(formular);
    await Future.delayed(const Duration(milliseconds: 50));
    FormElement _formActivitati = querySelector("#formActivitati") as FormElement;
    late final UListElement lista = querySelector('#listaActivitati') as UListElement;
    Element _numeFirma = querySelector("#numeFirma") as Element;
    _formFirma.replaceWith(_formActivitati);
    sufix = local.cauta('sufix').toString();
    if (sufix == '_ubf') {
      _numeFirma.innerHtml = 'UN BAIAT SI O FATA SRL';
    } else {
      _numeFirma.innerHtml = 'ALEX THEO PARTY SRL';
    }
    tabel = tabel + sufix;
    loader
        .cautaPeServer(
      criteriu: sufix,
      numeServer: 'serverActivitati',
      optiune: 'xxx',
      tabel: tabel,
    )
        .then((rezultat) {
      final _json = json.decode(rezultat);
      lista.children.clear();
      for (int i = 0; i < _json.length; i++) {
        LIElement elem = LIElement();
        lista.children.add(elem..text = _json[i]['activitate']);
        elem.onClick.listen((e) {
          Global.denActivitate = _json[i]['activitate'];

          local.adauga('activitate', Global.denActivitate);
          window.location.reload();
        });
      }
    });
  }
}
