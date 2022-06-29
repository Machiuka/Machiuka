import 'dart:html';
import 'dart:convert';
import 'load_detalii.dart';
import 'global.dart';
import 'ubf_factura.dart';
import '../meniuri/cautare_element.dart';
import 'package:intl/intl.dart';

class DetaliiFactura {
  Future detaliiArticol(String tipDoc) async {
    FormElement _formDetalii = querySelector("#formDetalii") as FormElement;
    LoadDetalii.incarcFormular('html/form_element.html');
    await Future.delayed(const Duration(milliseconds: 50));
    FormElement _formElement = querySelector("#formElement") as FormElement;
    InputElement _denumire = querySelector("#denumire") as InputElement;
    InputElement _cod = querySelector("#cod") as InputElement;
    InputElement _valabilitate = querySelector("#valabilitate") as InputElement;
    InputElement _ctva = querySelector("#ctva") as InputElement;
    InputElement _cantitate = querySelector("#cantitate") as InputElement;
    InputElement _unitMas = querySelector("#unitMas") as InputElement;
    InputElement _pret = querySelector("#pret") as InputElement;
    Element _textElem = querySelector("#titluElement") as Element;
    Element _btnAdaug = querySelector("#btnAdaug") as Element;
    Element _btnAnulez = querySelector("#btnAnulez") as Element;
    _btnAdaug.hidden = true;

    _formDetalii.replaceWith(_formElement);

    _textElem.innerHtml = UBFFactura.articol['denumire'];
    _denumire.defaultValue = UBFFactura.articol['denumire'];
    _valabilitate.defaultValue = UBFFactura.articol['valabilitate'];
    _unitMas.defaultValue = UBFFactura.articol['unit_mas'];
    _ctva.defaultValue = UBFFactura.articol['ctva'];
    _pret.defaultValue = UBFFactura.articol['pret'];
    _cod.defaultValue = 'Cod: ' + UBFFactura.articol['codElem'];
    _cantitate.onChange.listen((event) => _btnAdaug.hidden = false);

    _btnAdaug.onClick.listen((e) {
      //  UBFFactura.nrFact = (UBFFactura.nrFact! + 1);
      UBFFactura.articol['cantitate'] = _cantitate.value;
      UBFFactura.articol['valabilitate'] = _valabilitate.value;

      UBFFactura.articol['ctva'] = _ctva.value;
      double ctva = double.parse(_ctva.value!);
      double cantitate = double.parse(_cantitate.value!);
      double pret = double.parse(_pret.value!);

      double tvaProdus = double.parse((pret * ctva / (100 + ctva) * Global.precision).toStringAsFixed(2));
      tvaProdus = tvaProdus / Global.precision;
      double tva = tvaProdus * cantitate;
      double valCuTva = pret * cantitate;
      double val = valCuTva;
      if (tipDoc == 'fe') {
        pret = pret - tvaProdus;
        val = valCuTva - tva;
      }

      UBFFactura.articol['pret'] = pret.toStringAsFixed(2);
      UBFFactura.articol['tva'] = tva.toStringAsFixed(2);
      UBFFactura.articol['valoare'] = val.toStringAsFixed(2);
      //transform map in sir json
      UBFFactura.articoleFactura = UBFFactura.articoleFactura + jsonEncode(UBFFactura.articol) + ',';
      //window.alert(UBFFactura.articoleFactura);
      final DateFormat formatareData = DateFormat('yyyy-M-dd');
      UBFFactura.dataFact = formatareData.format(DateTime.now());
      UBFFactura.totalFactFaraTva = UBFFactura.totalFactFaraTva + val;
      UBFFactura.totalFactura = UBFFactura.totalFactura + valCuTva;
      UBFFactura.tva = UBFFactura.tva + tva;
      //window.alert("valoare fara tva=" + val.toString() + " Valoare cu tva=" + valCuTva.toString() + " tva=" + tva.toString());

      if (ctva == 19) {
        UBFFactura.tva19 = UBFFactura.tva19 + tva;
      } else {
        UBFFactura.tva9 = UBFFactura.tva9 + tva;
      }
      // window.alert('Articole factura = ${UBFFactura.articoleFactura}');
      _formElement.remove();
      if (tipDoc == 'fe') {
        CautareElement.cautareElement("FACTURA");
      }
      if (tipDoc == 'av') {
        CautareElement.cautareElement("AVIZ");
      }
    });
    _btnAnulez.onClick.listen((e) {
      _formElement.remove();
      if (tipDoc == 'fe') {
        CautareElement.cautareElement('FACTURA');
      }
      if (tipDoc == 'av') {
        CautareElement.cautareElement('AVIZ');
      }
    });
  }
}
