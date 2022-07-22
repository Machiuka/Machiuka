import 'dart:convert';
import 'dart:html';
import '../meniuri/cautare_element.dart';
import 'loader.dart';
import 'ubf_factura.dart';
import 'ubf_client.dart';
import 'load_detalii.dart';
import 'detalii_factura.dart';

import '../forms/invoice.dart';
import '../forms/invoice_body.dart';
import '../forms/nir.dart';
import '../forms/form_factura.dart';

class LoadFactura {
  Future loadArticol(String tipDoc, String caut, String tabel, String numeServer) async {
    //cauta produse pt factura

    FormElement _formCautare = querySelector("#formCautare") as FormElement;
    LoadDetalii.incarcFormular('html/form_detalii.html');
    await Future.delayed(const Duration(milliseconds: 50));
    FormElement _formDetalii = querySelector("#formDetalii") as FormElement;
    DivElement _divButoane = querySelector('.butoane') as DivElement;
    _divButoane.hidden = true;
    _formCautare.replaceWith(_formDetalii);

    late final UListElement lista = querySelector('#listaDetalii') as UListElement;

    Loader kk = Loader();
    kk.cautaPeServer(criteriu: caut, numeServer: numeServer, optiune: "r", tabel: tabel).then((rezultat) async {
      //   window.alert(rezultat);
      final _json = json.decode(rezultat);
      lista.children.clear();
      for (int i = 0; i < _json.length; i++) {
        LIElement elem = LIElement();
        lista.children.add(elem..text = _json[i]['denumire']);
        if (_json[i]['denumire'] == "Nu s-au gasit rezultate") {
          await Future.delayed(const Duration(seconds: 1));
          _formDetalii.remove();
          if (tipDoc == 'fe') {
            CautareElement.cautareElement('FACTURA');
          }
          if (tipDoc == 'av') {
            CautareElement.cautareElement('AVIZ');
          }
        }
        elem.onClick.listen((e) async {
          UBFFactura.articol['codElem'] = _json[i]['cod_doc'];
          UBFFactura.articol['denumire'] = _json[i]['denumire'];
          UBFFactura.listaPret = UBFClient.listaPret;
          String pretS = _json[i]['pret_vanzare' + UBFFactura.listaPret];
          double pret = double.parse(pretS);

          if (UBFFactura.adaos > 0) {
            pret = pret * (1 + UBFFactura.adaos / 100);
          }
          UBFFactura.articol['pret'] = pret.round();

          UBFFactura.articol['valabilitate'] = _json[i]['valabilitate']; //termenul de valabilitate e necesar la completarea Certif de garantie

          UBFFactura.articol['ctva'] = _json[i]['cota_tva'];

          if (_json[i]['gramaj'] == '1000') {
            UBFFactura.articol['unit_mas'] = 'kg';
          } else {
            UBFFactura.articol['unit_mas'] = 'buc';
          }

          DetaliiFactura detaliiFactura = DetaliiFactura();
          detaliiFactura.detaliiArticol(tipDoc);
        });
      }
    });
  }

  //****************************** */
  Future loadClient(String tipDoc, String caut, String tabel, String numeServer) async {
    //Cauta clientul dupa criteriul de cautare si returneaza datele lui, spre a fi adaugate in factura

    // FormElement _formCautare = querySelector("#formCautare") as FormElement;
    // LoadDetalii.incarcFormular('html/form_detalii.html');
    //await Future.delayed(const Duration(milliseconds: 50));
    FormElement _formDetalii = querySelector("#formDetalii") as FormElement;
    DivElement _divButoane = querySelector('.butoane') as DivElement; //nu am nevoie de butoane
    _divButoane.hidden = true;

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
      //   window.alert(rezultat);
      final _json = json.decode(rezultat);
      lista.children.clear();
      for (int i = 0; i < _json.length; i++) {
        LIElement elem = LIElement();
        lista.children.add(elem..text = _json[i]['denumire']);
        if (_json[i]['denumire'] == "Nu s-au gasit rezultate") {
          window.location.reload();
        } else {
          elem.onClick.listen((e) async {
            UBFClient.adresa = _json[i]['adresa'];
            UBFClient.denumire = _json[i]['denumire'];
            UBFClient.ciNr = _json[i]['ci_numar'];
            UBFClient.cui = _json[i]['cod_fiscal'];
            UBFClient.cif = _json[i]['reg_com'];
            UBFClient.ciPol = _json[i]['ci_pol'];
            UBFClient.delegat = _json[i]['delegat'];
            UBFClient.analitic = _json[i]['analitic'];
            UBFClient.masina = _json[i]['masina'];
            UBFClient.listaPret = _json[i]['lista_pret'];
            UBFClient.adaos = _json[i]['adaos'] != null ? int.parse(_json[i]['adaos']) : 0;

            UBFClient.discount = int.parse(_json[i]['discount']);
            UBFClient.tPlata = int.parse(_json[i]['t_plata']);
            //Am stabilit clientul acum cautam articolele din factura
            _formDetalii.remove();

            FormFactura.dateClient(tipDoc);
          });
        }
      }
    });
  }
  //---------------------------------

  loadInterogare(String tipDoc, String caut, String tabel, String numeServerPrimar, [bool modificare = false]) async {
    //cauta pe serverul primar ceea ce primeste din meniul cautare

    //FormElement _formCautare = querySelector("#formCautare") as FormElement;
    LoadDetalii.incarcFormular('html/form_detalii.html');
    await Future.delayed(const Duration(milliseconds: 50));
    FormElement _formDetalii = querySelector("#formDetalii") as FormElement;
    DivElement _divButoane = querySelector('.butoane') as DivElement;
    _divButoane.hidden = true;
    //_formCautare.replaceWith(_formDetalii);

    late final UListElement lista = querySelector('#listaDetalii') as UListElement;
    Loader kk = Loader();
    kk
        .cautaPeServer(
      criteriu: caut,
      numeServer: numeServerPrimar,
      optiune: "r",
      tabel: tabel,
    )
        .then((rezultat) async {
      //Elimina \ si " din rezultat
      rezultat = rezultat.replaceAll("\\", "");
      rezultat = rezultat.replaceAll('"{', '{');
      rezultat = rezultat.replaceAll('}"', '}');
      //print(rezultat);
      //window.alert(rezultat);
      rezultat = "[" + rezultat + "]";
      // print(rezultat);
      final _json = json.decode(rezultat);
      // window.alert(rezultat);
      lista.children.clear();
      for (int i = 0; i < _json.length; i++) {
        LIElement elem = LIElement();

        String _lung = _json[i]['nr_nir'].toString();
        if (tipDoc == "nir" && _lung.length > 1) {
          lista.children.add(elem..text = _json[i]['cod_doc'] + "/" + _json[i]['data_doc'] + " (" + _json[i]['date_partener']['denumire'] + ")");
        }
        if (tipDoc != "nir") {
          lista.children.add(elem..text = _json[i]['cod_doc'] + "/" + _json[i]['data_doc'] + " (" + _json[i]['date_partener']['denumire'] + ")");
        }

        if (_json[i]['data_doc'] == "Nu s-au gasit rezultate") {
          await Future.delayed(const Duration(seconds: 1));
          _formDetalii.remove();
          if (tipDoc == 'fe') {
            CautareElement.cautareElement('FACTURA');
          }
          if (tipDoc == 'av') {
            CautareElement.cautareElement('AVIZ');
          }
        }
        elem.onClick.listen((e) async {
          _formDetalii.remove();
          if (tipDoc == "nir") {
            NIR.afisNir(tipDoc, _json[i]);
          } else {
            if (modificare == true) {
              InvoiceBody.afisFactura(tipDoc, _json[i]);
            } else {
              Invoice.afisFactura(tipDoc, _json[i]);
            }
          }
        });
      } //print(rezultat);
    });
  }

  loadStergere(String tipDoc, String tabel, String numeServer) {
    //cauta pe serverul si primeste o lista clickabila. Sterge apoi elementul selectat, dupa id

    Loader kk = Loader();
    kk
        .cautaPeServer(
      criteriu: tipDoc,
      numeServer: numeServer,
      optiune: "d",
      tabel: tabel,
    )
        .then((rezultat) {
      //window.alert(rezultat);
      final _json = json.decode(rezultat);
      window.alert(_json['STERGERE']);
      window.location.reload();
    });
  }

  loadIncarcareFact(String tabel, String numeServer, String tipDoc, UBFFactura? factData, String optiune) {
//Incarca date pe server. Despre Useri sau Documente
//optiune este c -create sau u - update
    Loader kk = Loader();

    if (factData != null) {
      kk.adaugaPeServer(numeServer: numeServer, opt: optiune, tipDoc: tipDoc, tabel: tabel, factData: factData).then((rezultat) async {
        //await Future.delayed(const Duration(milliseconds: 50));

        try {
          //Elimina \ si " din rezultat
          rezultat = rezultat.replaceAll("\\", "");
          rezultat = rezultat.replaceAll('"{', '{');
          rezultat = rezultat.replaceAll('}"', '}');
          //    print(rezultat);
          //   window.alert("Raspuns server: " + rezultat);
          final _json = json.decode(rezultat);

          Invoice.afisFactura(tipDoc, _json);
        } catch (e) {
          window.alert('EROARE!!!...' + e.toString());
        }
      });
    } else {
      window.alert('factData NULL');
    }
  }
}
