import 'dart:html';
import '../clase/load_detalii.dart';
import '../clase/ubf_document.dart';
import '../clase/global.dart';
import '../clase/local_storage.dart';
import 'package:intl/intl.dart';

import 'cautare_element.dart';

class AdaugareReteta {
  static void adaugareReteta(String titlu, String tabel, String server) async {
    //Aici adauga retete

    //UBFDocument document = UBFDocument();
    LocalStorage local = LocalStorage();
    String _activitate = local.cauta('activitate').toString();
    FormElement _formDetalii = querySelector("#formDetalii") as FormElement;
    LoadDetalii.incarcFormular('html/form_reteta.html');
    await Future.delayed(const Duration(milliseconds: 150));

    Element _btnAdauga = querySelector('#btnAdauga') as Element;
    Element _btnAnulare = querySelector('#btnAnulare') as Element;
    FormElement _formDocument = querySelector('#formReteta') as FormElement;
    _formDetalii.replaceWith(_formDocument);
    Element _titluDocument = querySelector('#titluReteta') as Element;
    _titluDocument.innerHtml = titlu;

    InputElement _codPF = querySelector("#codPF") as InputElement;
    InputElement _denumirePF = querySelector("#denumire") as InputElement;
    InputElement _valabilitate = querySelector("#valabilitate") as InputElement;
    InputElement _pretVanzare = querySelector("#pretVanzare") as InputElement;
    InputElement _cotaTVA = querySelector("#cotaTVA") as InputElement;
    InputElement _descriere = querySelector("#descriere") as InputElement;
    InputElement _gramaj = querySelector("#gramaj") as InputElement;
    InputElement _obsDoc = querySelector("#obsDoc") as InputElement;

    if (titlu == "Adauga Reteta") {
      _codPF.defaultValue = (Global.ultimNumar['nrProdus']! + 1).toString();
      _denumirePF.placeholder = "Denumire Produs Finit";
      _valabilitate.placeholder = "Termen de valabilitate in zile";
    }

    _btnAdauga.onClick.listen((e) async {
      // final DateTime dataCurenta = DateTime.parse(_dataDoc.value.toString());
      final DateFormat formatareData = DateFormat('yyyy-M-dd');
      final String dataDoc = formatareData.format(DateTime.now());
      UBFDocument.tipDoc = 'rt';
      UBFDocument.cotaTVA = _cotaTVA.valueAsNumber as int?;
      UBFDocument.dataDoc = dataDoc; //preia automat data curenta
      UBFDocument.codElem = _codPF.value;
      UBFDocument.descriere = _descriere.value;
      UBFDocument.denumire = _denumirePF.value;
      UBFDocument.valabilitate = _valabilitate.valueAsNumber as int?;
      UBFDocument.gramaj = _gramaj.valueAsNumber as int?;
      UBFDocument.obsDoc = _obsDoc.value;
      UBFDocument.activitate = _activitate;
      UBFDocument.pretVanzare = _pretVanzare.valueAsNumber as double?;

      _formDocument.remove();

      CautareElement.cautareElement('RETETAR');
    });

    _btnAnulare.onClick.listen((e) {
      window.location.reload(); //echivalent cu refresh pagina
      LoadDetalii.incarcFormular('html/top_nav.html');
    });
  }
}
