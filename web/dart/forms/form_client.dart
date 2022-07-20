import 'dart:html';
import '../clase/load_detalii.dart';
import '../clase/ubf_client.dart';
import '../clase/global.dart';

class FormClient {
  static void formClient() async {
    //tip operatie este CRUD (c,r,u sau d)
    String formular = 'html/form_client.html';

    LoadDetalii.incarcFormular(formular);
    await Future.delayed(const Duration(milliseconds: 50));

    Element _btnAnulare = querySelector("#btnAnClient") as Element;
    Element _btnAdauga = querySelector("#btnAdClient") as Element;
    InputElement _codClient = querySelector("#codClient") as InputElement;
    InputElement _numeClient = querySelector("#numeClient") as InputElement;
    InputElement _delegat = querySelector("#delegatClient") as InputElement;
    InputElement _ciDelegat = querySelector("#ciDelegatC") as InputElement;
    InputElement _ciPol = querySelector("#ciPolC") as InputElement;
    InputElement _masina = querySelector("#masinaC") as InputElement;
    InputElement _discount = querySelector("#discountC") as InputElement;
    InputElement _adaos = querySelector("#adaosC") as InputElement;
    InputElement _tPlata = querySelector("#tPlataC") as InputElement;
    InputElement _cuiClient = querySelector("#cuiClient") as InputElement;
    InputElement _cifClient = querySelector("#cifClient") as InputElement;
    InputElement _adresaClient = querySelector("#adresaClient") as InputElement;
    InputElement _telClient = querySelector("#telClient") as InputElement;
    InputElement _emailClient = querySelector("#emailClient") as InputElement;
    InputElement _contClient = querySelector("#contClient") as InputElement;
    InputElement _bancaClient = querySelector("#bancaClient") as InputElement;
    InputElement _analitic = querySelector("#contAnalitic") as InputElement;
    InputElement _numeAgent = querySelector("#numeAgent") as InputElement;
    InputElement _grupaClient = querySelector("#grupaClient") as InputElement;
    InputElement _listaPret = querySelector("#listaPret") as InputElement;

    _codClient.defaultValue = (Global.ultimNumar['nrClient']! + 1).toString();
    LoadDetalii ld = LoadDetalii();
    UBFClient client = UBFClient();

    _btnAdauga.onClick.listen((e) {
      UBFClient.codElem = int.parse(_codClient.defaultValue!);
      UBFClient.denumire = _numeClient.value;
      UBFClient.delegat = _delegat.value;
      UBFClient.ciNr = _ciDelegat.value;
      UBFClient.ciPol = _ciPol.value;
      UBFClient.masina = _masina.value;
      UBFClient.discount = _discount.value != null ? int.parse(_discount.value!) : 0;
      UBFClient.adaos = _adaos.value != null ? int.parse(_adaos.value!) : 0;
      UBFClient.tPlata = _tPlata.value != null ? int.parse(_tPlata.value!) : 0;
      UBFClient.cui = _cuiClient.value;
      UBFClient.cif = _cifClient.value;
      UBFClient.adresa = _adresaClient.value;
      UBFClient.tel = _telClient.value;
      UBFClient.email = _emailClient.value;
      UBFClient.contBanca = _contClient.value;
      UBFClient.banca = _bancaClient.value;
      UBFClient.analitic = _analitic.value;
      UBFClient.grupa = _grupaClient.value;
      UBFClient.numeAgent = _numeAgent.value;
      UBFClient.listaPret = _listaPret.value == 0 ? "" : _listaPret.value.toString();

      ld.loadIncarcareClient('tbl_parteneri', 'serverAdaugClient', 'c', client);
    });
    _btnAnulare.onClick.listen((e) => window.location.reload());
  }

  static void formUpdateClient() async {
    //tip operatie este CRUD (c,r,u sau d)
    String formular = 'html/form_client.html';

    LoadDetalii.incarcFormular(formular);
    await Future.delayed(const Duration(milliseconds: 50));

    Element _btnAnulare = querySelector("#btnAnClient") as Element;
    Element _btnAdauga = querySelector("#btnAdClient") as Element;
    InputElement _codClient = querySelector("#codClient") as InputElement;
    InputElement _numeClient = querySelector("#numeClient") as InputElement;
    InputElement _delegat = querySelector("#delegatClient") as InputElement;
    InputElement _ciDelegat = querySelector("#ciDelegatC") as InputElement;
    InputElement _ciPol = querySelector("#ciPolC") as InputElement;
    InputElement _masina = querySelector("#masinaC") as InputElement;
    InputElement _discount = querySelector("#discountC") as InputElement;
    InputElement _adaos = querySelector("#adaosC") as InputElement;
    InputElement _tPlata = querySelector("#tPlataC") as InputElement;
    InputElement _cuiClient = querySelector("#cuiClient") as InputElement;
    InputElement _cifClient = querySelector("#cifClient") as InputElement;
    InputElement _adresaClient = querySelector("#adresaClient") as InputElement;
    InputElement _telClient = querySelector("#telClient") as InputElement;
    InputElement _emailClient = querySelector("#emailClient") as InputElement;
    InputElement _contClient = querySelector("#contClient") as InputElement;
    InputElement _bancaClient = querySelector("#bancaClient") as InputElement;
    InputElement _analitic = querySelector("#contAnalitic") as InputElement;
    InputElement _numeAgent = querySelector("#numeAgent") as InputElement;
    InputElement _grupaClient = querySelector("#grupaClient") as InputElement;
    InputElement _listaPret = querySelector("#listaPret") as InputElement;
//-----------------------------------------------

    _codClient.defaultValue = UBFClient.codElem.toString();
    _numeClient.defaultValue = UBFClient.denumire;
    _delegat.defaultValue = UBFClient.delegat;
    _ciDelegat.defaultValue = UBFClient.ciNr;
    _ciPol.defaultValue = UBFClient.ciPol;
    _masina.defaultValue = UBFClient.masina;
    _adaos.defaultValue = UBFClient.adaos.toString();
    _discount.defaultValue = UBFClient.discount.toString();
    _tPlata.defaultValue = UBFClient.tPlata.toString();
    _cifClient.defaultValue = UBFClient.cif;
    _cuiClient.defaultValue = UBFClient.cui;
    _adresaClient.defaultValue = UBFClient.adresa;
    _telClient.defaultValue = UBFClient.tel;
    _emailClient.defaultValue = UBFClient.email;
    _contClient.defaultValue = UBFClient.contBanca;
    _bancaClient.defaultValue = UBFClient.banca;
    _analitic.defaultValue = UBFClient.analitic;
    _numeAgent.defaultValue = UBFClient.numeAgent;
    _grupaClient.defaultValue = UBFClient.grupa;

    LoadDetalii ld = LoadDetalii();
    UBFClient client = UBFClient();

    _btnAdauga.onClick.listen((e) {
      UBFClient.codElem = int.parse(_codClient.defaultValue!);
      UBFClient.denumire = _numeClient.value;
      UBFClient.delegat = _delegat.value;
      UBFClient.ciNr = _ciDelegat.value;
      UBFClient.ciPol = _ciPol.value;
      UBFClient.masina = _masina.value;
      UBFClient.adaos = _adaos.value != null ? int.parse(_adaos.value!) : 0;
      UBFClient.discount = _discount.value != null ? int.parse(_discount.value!) : 0;
      UBFClient.tPlata = _tPlata.value != null ? int.parse(_tPlata.value!) : 0;
      UBFClient.cui = _cuiClient.value;
      UBFClient.cif = _cifClient.value;
      UBFClient.adresa = _adresaClient.value;
      UBFClient.tel = _telClient.value;
      UBFClient.email = _emailClient.value;
      UBFClient.contBanca = _contClient.value;
      UBFClient.banca = _bancaClient.value;
      UBFClient.analitic = _analitic.value;
      UBFClient.grupa = _grupaClient.value;
      UBFClient.numeAgent = _numeAgent.value;
      UBFClient.listaPret = _listaPret.value == 0 ? "" : _listaPret.value.toString();

      ld.loadIncarcareClient('tbl_parteneri', 'serverAdaugClient', 'u', client);
      window.location.reload();
    });

    _btnAnulare.onClick.listen((e) => window.location.reload());
  }
}
