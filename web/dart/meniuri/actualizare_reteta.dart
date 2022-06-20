import 'dart:convert';
import 'dart:html';
import 'package:intl/intl.dart';

import '../clase/ubf_document.dart';
import '../clase/load_detalii.dart';
import '../clase/loader.dart';
import '../clase/global.dart';

class ActualizareReteta {
  actualizareReteta(String caut, String tabel, String numeServer) {
    //cauta pe serverul primar ceea ce primeste din meniul cautare si afiseaza detaliile primite de pe serverul secundar
    //de pe serverul primar primeste o lista clickabila si de pe cel secundar primeste un tabel cu detaliile elementului selectat din lista
    late final UListElement lista = querySelector('#listaDetalii') as UListElement;

    LoadDetalii ld = LoadDetalii();
    Loader kk = Loader();
    kk
        .cautaPeServer(
      criteriu: caut,
      numeServer: numeServer,
      optiune: "r",
      tabel: tabel,
    )
        .then((rezultat) {
      //   window.alert(rezultat);
      final _json = json.decode(rezultat);
      lista.children.clear();
      for (int i = 0; i < _json.length; i++) {
        LIElement elem = LIElement();
        lista.children.add(elem..text = _json[i]['denumire']);
        elem.onClick.listen((e) {
          String crit = _json[i]['cod_doc'];
          kk.cautaPeServer(criteriu: crit, tabel: tabel, numeServer: numeServer, optiune: "u").then((value) async {
            value = value.replaceAll("[", "");
            value = value.replaceAll("]", "");
            //window.alert(value);

            final _js = json.decode(value);

            lista.children.clear();
            FormElement formDetalii = querySelector("#formDetalii") as FormElement;

            LoadDetalii.incarcFormular('html/form_update_reteta.html');
            await Future.delayed(const Duration(milliseconds: 50));
            FormElement formUpdate = querySelector("#formUpdateReteta") as FormElement;
            Element _btnInapoi = querySelector("#btnAnu") as Element;
            Element _btnAdauga = querySelector("#btnAda") as Element;
            InputElement _codElem = querySelector("#codElem") as InputElement;
            InputElement _denumire = querySelector("#denumire") as InputElement;
            InputElement _gramaj = querySelector("#gramaj") as InputElement;
            InputElement _valabilitate = querySelector("#valabilitate") as InputElement;
            InputElement _descriere = querySelector("#descriere") as InputElement;
            InputElement _pretVanzare = querySelector("#pretVanzare") as InputElement;
            InputElement _cotaTVA = querySelector("#cotaTVA") as InputElement;
            InputElement _obsDoc = querySelector("#obsDoc") as InputElement;
            InputElement _linkPhoto = querySelector("#linkPhoto") as InputElement;

            formDetalii.replaceWith(formUpdate);

            _codElem.value = _js['cod_doc'];
            _denumire.value = _js['denumire'];
            _gramaj.value = _js['gramaj'];
            _valabilitate.value = _js['valabilitate'];
            _descriere.value = _js['descriere'];
            _pretVanzare.value = _js['pret_vanzare'];
            _cotaTVA.value = _js['cota_tva'];
            _obsDoc.value = _js['obs'];
            _linkPhoto.value = _js['link_photo'];

            _btnAdauga.onClick.listen((event) async {
              //Adauga informatiile actualizate
              final DateFormat formatareData = DateFormat('yyyy-M-dd');
              final String dataDoc = formatareData.format(DateTime.now());

              //  window.alert(_cotaTVA.valueAsNumber.runtimeType.toString());

              UBFDocument.cotaTVA = _cotaTVA.valueAsNumber! > 0 ? _cotaTVA.valueAsNumber as int : 9;
              UBFDocument.dataDoc = dataDoc;
              UBFDocument.valabilitate = _valabilitate.valueAsNumber as int;
              UBFDocument.denumire = _denumire.value;
              UBFDocument.descriere = _descriere.value;
              UBFDocument.gramaj = _gramaj.valueAsNumber! > 0 ? _gramaj.valueAsNumber as int : 0;
              UBFDocument.obsDoc = _obsDoc.value;
              UBFDocument.pretVanzare = _pretVanzare.valueAsNumber! > 0 ? _pretVanzare.valueAsNumber as double : 0.0;
              UBFDocument.linkPhoto = _linkPhoto.value;
              UBFDocument.operator = Global.operator;
              UBFDocument.codElem = _codElem.value;
              LoadDetalii.incarcFormular('html/form_document.html'); //Este cerut la raspuns_tabel
              await Future.delayed(const Duration(milliseconds: 50));
              //   window.alert(Global.continut);
              formUpdate.remove();
              ld.loadIncarcareDoc("tbl_produse", "serverUpdateReteta", "rt", UBFDocument());
            });

            _btnInapoi.onClick.listen((event) {
              window.location.reload(); //echivalent cu refresh pagina
            });

            //   window.alert(titluTabel.innerHtml);

            //window.alert(_js.toString());
          });
        });
      }
    });
  }
}
