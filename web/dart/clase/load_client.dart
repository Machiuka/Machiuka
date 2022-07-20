import 'dart:html';
import 'dart:convert';
import '../forms/form_client.dart';
import 'ubf_client.dart';
import 'loader.dart';

import 'load_detalii.dart';
import 'tabelare.dart';

class LoadClient {
  Future loadClient(String crud, String caut, String tabel, String numeServer) async {
    //Cauta clientul dupa criteriul de cautare si returneaza datele lui, spre a fi adaugate in factura

    // FormElement _formCautare = querySelector("#formCautare") as FormElement;
    LoadDetalii.incarcFormular('html/form_detalii.html');
    await Future.delayed(const Duration(milliseconds: 50));
    FormElement _formDetalii = querySelector("#formDetalii") as FormElement;
    DivElement _divButoane = querySelector('.butoane') as DivElement; //nu am nevoie de butoane
    _divButoane.hidden = true;
    LoadDetalii ld = LoadDetalii();
    UBFClient client = UBFClient();
    late final UListElement lista = querySelector('#listaDetalii') as UListElement;

    Loader kk = Loader();
    kk
        .cautaPeServer(
      criteriu: caut,
      numeServer: numeServer,
      optiune: "r",
      tabel: tabel,
    )
        .then((rezultat) async {
      //window.alert(rezultat);
      final _json = json.decode(rezultat);
      //window.alert(_json['denumire']);
      lista.children.clear();
      for (int i = 0; i < _json.length; i++) {
        LIElement elem = LIElement();
        lista.children.add(elem..text = _json[i]['denumire']);
        if (_json[i]['denumire'] == "Nu s-au gasit rezultate") {
          window.location.reload();
        } else {
          elem.onClick.listen((e) async {
            UBFClient.codElem = int.parse(_json[i]['cod_doc']);
            UBFClient.denumire = _json[i]['denumire'];
            UBFClient.adresa = _json[i]['adresa'];
            UBFClient.analitic = _json[i]['analitic'];
            UBFClient.banca = _json[i]['banca'];
            UBFClient.ciNr = _json[i]['ci_numar'];
            UBFClient.ciPol = _json[i]['ci_pol'];
            UBFClient.cif = _json[i]['reg_com'];
            UBFClient.contBanca = _json[i]['cont_banca'];
            UBFClient.cui = _json[i]['cod_fiscal'];
            UBFClient.delegat = _json[i]['delegat'];
            UBFClient.adaos = _json[i]['adaos'] != null ? int.parse(_json[i]['adaos']) : 0;
            UBFClient.discount = int.parse(_json[i]['discount']);
            UBFClient.tPlata = int.parse(_json[i]['t_plata']);
            UBFClient.tel = _json[i]['tel'];
            UBFClient.email = _json[i]['email'];
            UBFClient.grupa = _json[i]['grupa'];
            UBFClient.masina = _json[i]['masina'];
            UBFClient.numeAgent = _json[i]['den_agent'];
            UBFClient.listaPret = _json[i]['lista_pret'];

            if (crud == 'd') {
              bool stergere = window.confirm('OK pt a confirma stergerea, cancel pt anulare!');
              if (stergere) {
                ld.loadIncarcareClient(tabel, 'serverAdaugClient', crud, client);
              } else {
                window.location.reload();
              }
            } else if (crud == 'r') {
              final String criteriu = UBFClient.denumire ?? '';

              kk.cautaPeServer(criteriu: criteriu, tabel: tabel, numeServer: numeServer, optiune: 'r').then((value) async {
                value = value.replaceAll("[", "");
                value = value.replaceAll("]", "");
                //     window.alert('Value este $value');
                final _js = json.decode(value);

                lista.children.clear();
                //       FormElement formDetalii =querySelector("#formDetalii") as FormElement;

                LoadDetalii.incarcFormular('html/form_tabel.html');
                await Future.delayed(const Duration(milliseconds: 50));
                Tabelare tabelul = Tabelare();
                FormElement formTabel = querySelector("#formTabel") as FormElement;
                Element titluTabel = querySelector("#titluTabel") as Element;
                Element btnInapoi = querySelector("#btnCCC") as Element;
                _formDetalii.replaceWith(
                    formTabel); //inlocuie formDetalii cu formTabel. Proprietatea hidden nu a functionat, iar remove() pierde metodele atasate butoanelor
                tabelul.adauga(_js, 'tabelDetalii', 0);
                btnInapoi.onClick.listen((event) {
                  window.location.reload();
                });

                titluTabel.innerHtml = "Detalii pt $criteriu";
              });

              //Am stabilit clientul acum cautam articolele din factura
              //_formDetalii.remove();

            } else if (crud == 'u') {
              _formDetalii.remove();
              FormClient.formUpdateClient();
            }
          });
        }
      }
    });
  }
}
