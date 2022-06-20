import 'dart:html';
import 'load_detalii.dart';
import 'global.dart';
import 'ubf_document.dart';
import '../meniuri/cautare_element.dart';

class DetaliiElement {
  Future detaliiElement() async {
    FormElement _formDetalii = querySelector("#formDetalii") as FormElement;
    LoadDetalii.incarcFormular('html/form_element.html');
    await Future.delayed(const Duration(milliseconds: 50));
    FormElement _formElement = querySelector("#formElement") as FormElement;
    InputElement _denumire = querySelector("#denumire") as InputElement;
    InputElement _cod = querySelector("#cod") as InputElement;
    InputElement _cantitate = querySelector("#cantitate") as InputElement;
    Element _textElem = querySelector("#titluElement") as Element;
    Element _btnAdaug = querySelector("#btnAdaug") as Element;
    Element _btnAnulez = querySelector("#btnAnulez") as Element;

    _formDetalii.replaceWith(_formElement);

    _textElem.innerHtml = UBFDocument.emitentDoc;
    _denumire.defaultValue = Global.denumire;
    _cod.defaultValue = 'Cod: ' + Global.cod_doc;

    _btnAdaug.onClick.listen((e) {
      Global.cantitate = _cantitate.value.toString();
      Global.continut = Global.continut + Global.cod_doc + '|' + Global.cantitate + '^';
      // window.alert('Continut= ${Global.continut}');
      _formElement.remove();
      CautareElement.cautareElement("RETETAR");
    });

    //cod.defaultValue = _json[i]['cod_doc'];
  }
}
