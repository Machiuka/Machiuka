import 'dart:convert';
import 'dart:html';
import 'ubf_document.dart';
import 'ubf_user.dart';
import 'loader.dart';
import 'tabelare.dart';
import 'raspuns_tabel.dart';
import 'global.dart';
import 'detalii_element.dart';
import 'ubf_client.dart';

class LoadDetalii {
  Future loadElement(String caut, String tabel, String numeServer) async {
    //cauta pe serverul primar ceea ce primeste din meniul cautare si afiseaza detaliile primite de pe serverul secundar
    //de pe serverul primar primeste o lista clickabila si de pe cel secundar primeste un tabel cu detaliile elementului selectat din lista

    FormElement _formCautare = querySelector("#formCautare") as FormElement;
    LoadDetalii.incarcFormular('html/form_detalii.html');
    await Future.delayed(const Duration(milliseconds: 50));

    FormElement _formDetalii = querySelector("#formDetalii") as FormElement;
    _formCautare.replaceWith(_formDetalii);

    late final UListElement lista =
        querySelector('#listaDetalii') as UListElement;
    FormElement formDetalii = querySelector("#formDetalii") as FormElement;
    Loader loader = Loader();
    loader
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
        elem.onClick.listen((e) async {
          Global.cod_doc = _json[i]['cod_doc'];
          Global.denumire = _json[i]['denumire'];
          Global.um = _json[i]['um'];
          DetaliiElement detaliiElement = DetaliiElement();

          detaliiElement.detaliiElement();
        });
      }
    });
  }

  loadRaportare(String tabel, String numeServerPrimar, String dataInceput,
      String dataSfarsit,
      [String? partener, String? produs]) {
    //cauta pe serverul primar ceea ce primeste din meniul cautare si afiseaza detaliile primite de pe serverul secundar
    //de pe serverul primar primeste o lista clickabila si de pe cel secundar primeste un tabel cu detaliile elementului selectat din lista
    //caut este partenerul
    late final UListElement lista =
        querySelector('#listaDetalii') as UListElement;
    FormElement formRaport = querySelector("#formRaport") as FormElement;
    Loader loader = Loader();
    String optiune = "";
    if (produs == '' && partener == '') {
      optiune = "gen";
    } else if (produs == '') {
      optiune = "cli";
    } else if (partener == '') {
      optiune = "pro";
    }
    loader
        .cautaPeServer(
            criteriu: partener!,
            numeServer: numeServerPrimar,
            optiune: optiune,
            tabel: tabel,
            dataInceput: dataInceput,
            dataSfarsit: dataSfarsit,
            produs: produs)
        .then((rezultat) async {
      window.alert(rezultat);
      final _json = json.decode(rezultat);
      //window.alert("Runtime= " + _json.runtimeType.toString());

      //       FormElement formDetalii =querySelector("#formDetalii") as FormElement;

      incarcFormular('html/form_tabel.html');
      await Future.delayed(const Duration(milliseconds: 50));
      Tabelare tabelul = Tabelare();
      FormElement formTabel = querySelector("#formTabel") as FormElement;
      Element titluTabel = querySelector("#titluTabel") as Element;
      Element btnInapoi = querySelector("#btnCCC") as Element;
      formRaport.replaceWith(
          formTabel); //inlocuie formDetalii cu formTabel. Proprietatea hidden nu a functionat, iar remove() pierde metodele atasate butoanelor
      tabelul.adauga(_json, 'tabelDetalii', 0);
      btnInapoi.onClick.listen((event) {
        formTabel.replaceWith(formRaport);
      });
      dataInceput =
          _convertData(dataInceput); // Converteste din yyyy-mm-dd in dd.mm.yyyy
      dataSfarsit = _convertData(dataSfarsit);

      if (partener == "") {
        titluTabel.innerHtml =
            "RAPORT LIVRARI ${dataInceput}  -  ${dataSfarsit}";
      } else {
        titluTabel.innerHtml =
            "RAPORT LIVRARI $partener perioada ${dataInceput}  -  ${dataSfarsit}";
      }
    });
  }

  String _convertData(String dataC) {
    String dataCon = "";
    String luna = "";
    String ziua = "";
    String anul = "";
    int lungime = dataC.length;
    ziua = dataC.substring(lungime - 2);
    dataC = dataC.substring(0, lungime - 3);
    lungime = dataC.length;
    luna = dataC.substring(lungime - 2);
    dataC = dataC.substring(0, lungime - 3);
    anul = dataC;
    dataCon = ziua + "." + luna + "." + anul;

    return dataCon;
  }

  loadInterogare(String caut, String tabel, String numeServerPrimar,
      [String numeServerSecundar = '']) {
    //cauta pe serverul primar ceea ce primeste din meniul cautare si afiseaza detaliile primite de pe serverul secundar
    //de pe serverul primar primeste o lista clickabila si de pe cel secundar primeste un tabel cu detaliile elementului selectat din lista
    late final UListElement lista =
        querySelector('#listaDetalii') as UListElement;
    FormElement formDetalii = querySelector("#formDetalii") as FormElement;
    Loader loader = Loader();
    loader
        .cautaPeServer(
      criteriu: caut,
      numeServer: numeServerPrimar,
      optiune: "r",
      tabel: tabel,
    )
        .then((rezultat) {
      final _json = json.decode(rezultat);
      lista.children.clear();
      for (int i = 0; i < _json.length; i++) {
        LIElement elem = LIElement();
        lista.children.add(elem..text = _json[i]['denumire']);
        elem.onClick.listen((e) {
          // String crit = elem.innerHtml.toString();
          String crit = _json[i]['cod_doc'];
          String den = _json[i]['denumire'];
//Pe serverCautSterg reteta am adaugat optiunea r1 iul.2022
          //     loader.cautaPeServer(criteriu: crit, tabel: tabel, numeServer: numeServerPrimar, optiune: "r").then((value) async {
          loader
              .cautaPeServer(
                  criteriu: crit,
                  tabel: tabel,
                  numeServer: numeServerPrimar,
                  optiune: "r1")
              .then((value) async {
            value = value.replaceAll("[", "");
            value = value.replaceAll("]", "");
            //    window.alert('Value reteta este $value');
            final _js = json.decode(value);

            lista.children.clear();
            //       FormElement formDetalii =querySelector("#formDetalii") as FormElement;

            incarcFormular('html/form_tabel.html');
            await Future.delayed(const Duration(milliseconds: 50));
            Tabelare tabelul = Tabelare();
            FormElement formTabel = querySelector("#formTabel") as FormElement;
            Element titluTabel = querySelector("#titluTabel") as Element;
            Element btnInapoi = querySelector("#btnCCC") as Element;
            formDetalii.replaceWith(
                formTabel); //inlocuie formDetalii cu formTabel. Proprietatea hidden nu a functionat, iar remove() pierde metodele atasate butoanelor
            tabelul.adauga(_js, 'tabelDetalii', 0);
            btnInapoi.onClick.listen((event) {
              formTabel.replaceWith(formDetalii);
            });

            titluTabel.innerHtml = "Detalii pt $den";
            //   window.alert(titluTabel.innerHtml);

            //window.alert(_js.toString());
          });
        });
      }
    });
  }

  loadStergere(String caut, String tabel, String numeServer) {
    //cauta pe serverul si primeste o lista clickabila. Sterge apoi elementul selectat, dupa id
    late final UListElement lista =
        querySelector('#listaDetalii') as UListElement;
    FormElement formDetalii = querySelector("#formDetalii") as FormElement;
    Loader loader = Loader();
    loader
        .cautaPeServer(
      criteriu: caut,
      numeServer: numeServer,
      optiune: "r",
      tabel: tabel,
    )
        .then((rezultat) {
      //  window.alert(rezultat);
      final _json = json.decode(rezultat);
      lista.children.clear();
      for (int i = 0; i < _json.length; i++) {
        LIElement elem = LIElement();
        lista.children.add(elem..text = _json[i]['denumire']);
        elem.onClick.listen((e) {
          bool confirmare = window.confirm(
              "Elementul ${_json[i]['denumire']} va fi sters. Ok, pt confirmare, Cancel pt anulare");
          if (confirmare) {
            String crit = _json[i]['id'].toString();
            //  window.alert('Criteriul de stergere este $crit');
            loader
                .cautaPeServer(
                    criteriu: crit,
                    tabel: tabel,
                    numeServer: numeServer,
                    optiune: "d")
                .then((value) async {
              value = value.replaceAll("[", "");
              value = value.replaceAll("]", "");

              final _js = json.decode(value);

              lista.children.clear();
              //       FormElement formDetalii =querySelector("#formDetalii") as FormElement;

              incarcFormular('html/form_tabel.html');
              await Future.delayed(const Duration(milliseconds: 50));
              Tabelare tabelul = Tabelare();
              FormElement formTabel =
                  querySelector("#formTabel") as FormElement;
              Element titluTabel = querySelector("#titluTabel") as Element;
              Element btnInapoi = querySelector("#btnCCC") as Element;
              formDetalii.replaceWith(
                  formTabel); //inlocuie formDetalii cu formTabel. Proprietatea hidden nu a functionat, iar remove() pierde metodele atasate butoanelor
              tabelul.adauga(_js, 'tabelDetalii', 0);
              btnInapoi.onClick.listen((event) {
                formTabel.replaceWith(formDetalii);
              });

              titluTabel.innerHtml = "Detalii pt ${_json[i]['denumire']}";
              //   window.alert(titluTabel.innerHtml);

              //window.alert(_js.toString());
            });
          } else {
            window.location.reload(); //echivalent cu refresh pagina
          }
        });
      }
    });
  }

  loadIncarcareDoc(
      String tabel, String numeServer, String tipDoc, UBFDocument? docData) {
//Incarca date pe server. Despre Useri sau Documente
    Loader loader = Loader();
    loader
        .adaugaPeServer(
            numeServer: numeServer,
            opt: "c",
            tipDoc: tipDoc,
            tabel: tabel,
            docData: docData)
        .then((rezultat) async {
      //window.alert(rezultat);
      try {
        rezultat = rezultat.replaceAll("\\", "");
        rezultat = rezultat.replaceAll('"{', '{');
        rezultat = rezultat.replaceAll('}"', '}');
        //  print(rezultat);
        //window.alert("Raspuns server: " + rezultat);
        final _json = json.decode(rezultat);
        // RaspunsTabel.raspunsTabel(_json);
        if (_json['eroare'] == null) {
          window.alert(
              "Produsul " + _json['denumire'] + " a fost adaugat/modificat!");
        } else {
          window.alert("Produsul/serviciul  exista!");
        }
        window.location.reload();
      } catch (e) {
        window.alert('EROARE!!!...' + e.toString());
      }
    });
  }

  loadIncarcareClient(
      String tabel, String numeServer, String crud, UBFClient? clientData) {
//Incarca date pe server. Despre Useri sau Documente
    //window.alert(UBFClient.codElem.toString());
    //window.alert(UBFClient.denumire);
    Loader loader = Loader();
    loader
        .adaugaPeServer(
            numeServer: numeServer,
            opt: crud,
            tipDoc: 'cl',
            tabel: tabel,
            clientData: clientData)
        .then((rezultat) async {
      //await Future.delayed(const Duration(milliseconds: 50));
      //    window.alert(rezultat);
      try {
        //     rezultat = rezultat.replaceAll("[", "");
        // rezultat = rezultat.replaceAll("]", "");
        //window.alert(rezultat);
        final _json = json.decode(rezultat);
        if (crud == 'c') {
          window.alert(
              "Clientul " + _json['denumire'] + " a fost creat cu succes!");
          window.location.reload();
        } else if (crud != 'd') {
          RaspunsTabel.raspunsTabel(_json);
        } else {
          //    window.alert(rezultat);
          window.location.reload();
        }
      } catch (e) {
        window.alert('EROARE!!!...' + e.toString());
      }
    });
  }

  loadIncarcareUser(
      String tabel, String tipDoc, String numeServer, UBFUser? docUser) {
//Incarca date pe server. Despre Useri sau Documente
    Loader loader = Loader();
    loader
        .adaugaPeServer(
            numeServer: numeServer,
            opt: "c",
            tipDoc: tipDoc,
            tabel: tabel,
            userData: docUser)
        .then((rezultat) {
      final _json = json.decode(rezultat);
    });
  }

  static void incarcFormular(String url) async {
//Metoda care insereaza formularele html in index.html
    //String url = 'html/top_nav.html';
    Element? _el = querySelector('#output');
    await HttpRequest.postFormData(url, {}).then((HttpRequest response) {
      String formular;

      if (response.status == 200) {
        formular = response.responseText!;
        _el!.insertAdjacentHtml('beforebegin', formular);
      }
    });
  }
}
