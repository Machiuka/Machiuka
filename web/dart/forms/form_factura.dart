import 'dart:html';
import '../meniuri/cautare_element.dart';
import '../clase/load_detalii.dart';
import '../clase/ubf_factura.dart';
import '../clase/ubf_client.dart';
import '../clase/global.dart';
import '../clase/local_storage.dart';

class FormFactura {
  static void dateClient(String tipDoc) async {
    //tip doc poate sa fie fi, fe, av, rt. Aici putem avea fe sau av
    String formular = 'html/form_factura.html';
    LocalStorage local = LocalStorage();
    LoadDetalii.incarcFormular(formular);
    await Future.delayed(const Duration(milliseconds: 50));
    FormElement _formFactura = querySelector("#formFactura") as FormElement;
    //DivElement _isFactura = querySelector('#isFactura') as DivElement;
    Element _titluFactura = querySelector('#titluFactura') as Element;

    Element _btnAnulare = querySelector("#btnAnulareF") as Element;
    Element _btnAdauga = querySelector("#btnAdaugaF") as Element;
    InputElement _nrFact = querySelector("#nrFact") as InputElement;
    InputElement _numeClient = querySelector("#numeClient") as InputElement;
    InputElement _nrLot = querySelector("#nrLot") as InputElement;
    InputElement _delegat = querySelector("#delegat") as InputElement;
    InputElement _ciDelegat = querySelector("#ciDelegat") as InputElement;
    InputElement _ciPol = querySelector("#ciPol") as InputElement;
    InputElement _masina = querySelector("#masina") as InputElement;
    InputElement _adaos = querySelector("#adaos") as InputElement;
    InputElement _discount = querySelector("#discount") as InputElement;
    InputElement _tPlata = querySelector("#tPlata") as InputElement;
    String _activitate = local.cauta('activitate').toString();
    _delegat.defaultValue = UBFClient.delegat;
    _ciDelegat.defaultValue = UBFClient.ciNr;
    _ciPol.defaultValue = UBFClient.ciPol;
    _masina.defaultValue = UBFClient.masina;
    _adaos.defaultValue = UBFClient.adaos.toString();
    _discount.defaultValue = UBFClient.discount.toString();
    _tPlata.defaultValue = UBFClient.tPlata.toString();
    if (tipDoc == 'fe') {
      _nrFact.defaultValue = (Global.ultimNumar['nrFactura']! + 1).toString();
      _titluFactura.innerHtml = 'FACTURA FISCALA';
    }
    if (tipDoc == 'av') {
      //  _isFactura.hidden = true; //la aviz  am totusi nevoie de ce este in div isFactura din form_factura.html
      _nrFact.defaultValue = (Global.ultimNumar['nrAviz']! + 1).toString();

      _titluFactura.innerHtml = 'AVIZ EXPEDITIE';
    }

    _numeClient.defaultValue = UBFClient.denumire;

    _btnAdauga.onClick.listen((e) {
      UBFFactura.nrFact = int.parse(_nrFact.defaultValue!);
      UBFFactura.activitate = _activitate;
      UBFFactura.adaos = int.parse(_adaos.value!);
      UBFClient.adaos = int.parse(_adaos.value!);
      if (tipDoc == 'fe') {
        Global.ultimNumar['nrFactura'] = UBFFactura.nrFact!;
      }

      UBFClient.discount = int.parse(_discount.value!);
      UBFClient.tPlata = int.parse(_tPlata.value!);

      UBFFactura.discount = int.parse(_discount.value!);
      UBFFactura.termenPlata = int.parse(_tPlata.value!);
      UBFFactura.achitata = UBFFactura.termenPlata > 0 ? 0 : 1;

      if (tipDoc == 'av') {
        Global.ultimNumar['nrAviz'] = UBFFactura.nrFact!;
        UBFFactura.nrNir = (Global.ultimNumar['nrNir']! + 1).toString();
      }
      UBFClient.nrLot = _nrLot.value;
      UBFClient.delegat = _delegat.value;
      UBFClient.ciNr = _ciDelegat.value;
      UBFClient.ciPol = _ciPol.value;
      UBFClient.masina = _masina.value;

      _formFactura.remove();
      if (tipDoc == 'fe') {
        CautareElement.cautareElement('FACTURA');
      }
      if (tipDoc == 'av') {
        CautareElement.cautareElement('AVIZ');
      }
    });
    _btnAnulare.onClick.listen((e) {
      window.location.reload();
    });
  }
}
