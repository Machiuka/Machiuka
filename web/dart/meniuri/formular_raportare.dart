import 'dart:html';
import '../clase/load_detalii.dart';
import '../clase/local_storage.dart';

class FormularRaportare {
  static void formular(bool extint) async {
    LocalStorage local = LocalStorage();
    LoadDetalii ld = LoadDetalii();
    LoadDetalii.incarcFormular('html/form_raportare.html');
    await Future.delayed(const Duration(milliseconds: 50));

    InputElement _dataInceput = querySelector("#inceput") as InputElement;
    InputElement _dataSfarsit = querySelector("#sfarsit") as InputElement;
    InputElement _produs = querySelector("#produs") as InputElement;
    InputElement _client = querySelector("#client") as InputElement;

    Element _btnAfis = querySelector('#btnAfis') as Element;
    Element _btnAnulare = querySelector('#btnAnulare') as Element;
    DivElement _divButoane = querySelector('.butoane') as DivElement;

    String tabelF = "tbl_facturi" + local.cauta('sufix').toString();
    String tabelA = "tbl_avize" + local.cauta('sufix').toString();

    String tabel = extint ? tabelF : tabelA;
    _dataSfarsit.onClick.listen((event) {
      if (_dataInceput.value != "") {
      } else {
        window.alert("Introduceti data de inceput");
      }
    });
    _client.onClick.listen((event) {
      _divButoane.hidden = false;
    });
    _btnAfis.onClick.listen((e) {
      ld.loadRaportare(tabel, "serverRaportare", _dataInceput.value!, _dataSfarsit.value!, _client.value!, _produs.value!);
    });
    _btnAnulare.onClick.listen((e) {
      window.location.reload(); //echivalent cu refresh pagina
    });
  }
}
