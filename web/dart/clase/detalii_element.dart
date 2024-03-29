import 'dart:convert';
import 'dart:html';
import 'load_detalii.dart';
import 'global.dart';
import 'ubf_document.dart';
import '../meniuri/cautare_element.dart';

class DetaliiElement {
  Future detaliiElement() async {
    FormElement _formDetalii = querySelector("#formDetalii") as FormElement;
    LoadDetalii.incarcFormular('html/form_mp.html');
    await Future.delayed(const Duration(milliseconds: 50));
    FormElement _formElement = querySelector("#formMP") as FormElement;
    InputElement _denumire = querySelector("#denumire") as InputElement;
    InputElement _cod = querySelector("#cod") as InputElement;
    InputElement _unitMas = querySelector("#unitMas") as InputElement;
    InputElement _pretMP = querySelector("#pretMP") as InputElement;
    InputElement _cantitate = querySelector("#cantitate") as InputElement;
    Element _textElem = querySelector("#titluElement") as Element;
    Element _btnAdaug = querySelector("#btnAdaug") as Element;
    Element _btnAnulez = querySelector("#btnAnulez") as Element;

    _formDetalii.replaceWith(_formElement);

    _textElem.innerHtml = UBFDocument.emitentDoc;
    _denumire.defaultValue = Global.denumire;
    _unitMas.defaultValue = Global.um;
    _cod.defaultValue = 'Cod: ' + Global.cod_doc;

    _btnAdaug.onClick.listen((e) {
      Global.cantitate = _cantitate.value.toString();
      Global.pret = _pretMP.value.toString();
      UBFDocument.articol['cantitate'] = Global.cantitate;
      UBFDocument.articol['codElem'] = Global.cod_doc;
      UBFDocument.articol['unitMas'] = Global.um;
      UBFDocument.articol['denumire'] = Global.denumire;
      UBFDocument.articol['pret'] = Global.pret;
      UBFDocument.articol['valoare'] =
          double.parse(Global.pret) * int.parse(Global.cantitate);
      UBFDocument.continutDoc =
          UBFDocument.continutDoc + jsonEncode(UBFDocument.articol) + ',';

      //Global.continut = Global.continut + Global.cod_doc + '|' + Global.cantitate + '^';

      // window.alert('Continut= ${Global.continut}');
      _formElement.remove();
      CautareElement.cautareElement("RETETAR");
    });

    //cod.defaultValue = _json[i]['cod_doc'];
  }
}
