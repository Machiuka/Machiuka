import 'dart:html';
import '../clase/ubf_factura.dart';
import '../clase/load_detalii.dart';
import 'dart:convert';
import '../clase/css.dart';
import 'package:intl/intl.dart';
import '../clase/local_storage.dart';

class Invoice {
  static void afisFactura(String tipDoc, Map<String, dynamic> _json) async {
    final styleSheet = document.styleSheets![0] as CssStyleSheet;
    String rule;

    if (_json['cod_doc'] == null) {
      window.alert('Document Inexistent!!!');
      window.location.reload();
    } else {
      CSS.aplicaCSS("css/invoice.css");

      // ignore: unnecessary_null_comparison
      String formular = 'html/invoice.html';
      bool cuPret = true;
      if (tipDoc == 'av') {
        cuPret = window.confirm(
            "Doriti afisare preturi? Ok, pt confirmare, Cancel pt afisare fara preturi");
        formular = 'html/aviz.html';
      }
      LocalStorage _local = LocalStorage();
      String? _activitate = _local.cauta("activitate");
      LoadDetalii.incarcFormular(formular);
      await Future.delayed(const Duration(milliseconds: 350));

      //Zona Vanzator
      LabelElement webpage = querySelector('#webpage') as LabelElement;
      LabelElement companyName = querySelector('#company_name') as LabelElement;
      LabelElement companyAddress =
          querySelector('#company_address') as LabelElement;
      LabelElement companycif = querySelector('#company_cif') as LabelElement;
      LabelElement companycui = querySelector('#company_cui') as LabelElement;
      LabelElement companytel = querySelector('#company_tel') as LabelElement;
      LabelElement companyemail =
          querySelector('#company_email') as LabelElement;
      LabelElement companybanca =
          querySelector('#company_banca') as LabelElement;
      LabelElement companytrezorerie =
          querySelector('#company_trezorerie') as LabelElement;
      SpanElement dataDoc1 = querySelector('.dataDoc1') as SpanElement;
      SpanElement dataDoc2 = querySelector('.dataDoc2') as SpanElement;
      SpanElement dataDoc3 = querySelector('.dataDoc3') as SpanElement;
      SpanElement totalGeneral = querySelector('#totalGeneral') as SpanElement;
      SpanElement totalTVA19 = querySelector('#totalTVA19') as SpanElement;
      SpanElement totalTVA9 = querySelector('#totalTVA9') as SpanElement;
      SpanElement totalTVA5 = querySelector('#totalTVA5') as SpanElement;
      SpanElement totalFact = querySelector('#totalFact') as SpanElement;
      SpanElement tPlata = querySelector('#tPlata') as SpanElement;
      SpanElement nrLot = querySelector('#nrLot')
          as SpanElement; //Nr lotului din care fac parte produsele
      SpanElement labo = querySelector('#labo') as SpanElement;
      TableRowElement rtva5 = querySelector('.tva5') as TableRowElement;
      TableRowElement rtva9 = querySelector('.tva9') as TableRowElement;

      LabelElement nrFact = querySelector('#cod_doc') as LabelElement;

//Zona Client
      LabelElement clientName = querySelector('#client_name') as LabelElement;
      LabelElement clientAddress =
          querySelector('#client_address') as LabelElement;
      LabelElement clientcif = querySelector('#client_cif') as LabelElement;
      LabelElement clientcui = querySelector('#client_cui') as LabelElement;
      SpanElement delegat = querySelector('#delegat') as SpanElement;
      SpanElement masina = querySelector('#nrAuto') as SpanElement;
      SpanElement ciDelegat = querySelector('#ciDelegat') as SpanElement;
      SpanElement ciPol = querySelector('#ciPol') as SpanElement;

//*************** */
      if (_activitate != "Laborator") {
        //Nu am nevoie sa imi afiseze lot si standard de firma decat la laborator
        labo.hidden = true;
      }
      final DateFormat formatareData = DateFormat('dd.M.yyyy');
      DateTime dataF = DateTime.parse(_json['data_doc']);
      String dataFs = formatareData.format(dataF);

      if (tipDoc == 'fe' || tipDoc == 'av') {
        int termenPlata = int.parse(_json['termen_plata']);
        DateTime dataP = dataF.add(new Duration(days: termenPlata));
        String dataFp = formatareData.format(dataP);
        tPlata.innerHtml = _json['termen_plata'];
        dataDoc3.innerHtml = dataFp;
      }

//Incarc zona Vanzator
      webpage.innerHtml = _json['date_firma']['webVanzator'];
      if (tipDoc == 'fe') {
        nrFact.innerHtml = UBFFactura.prefix + _json['cod_doc'].toString();
      } else {
        nrFact.innerHtml = _json['cod_doc'].toString();
      }
      companyAddress.innerHtml = _json['date_firma']['adresaVanzator'];
      companycif.innerHtml = _json['date_firma']['cifVanzator'];
      companycui.innerHtml = _json['date_firma']['cuiVanzator'];
      companytel.innerHtml = _json['date_firma']['telVanzator'];
      companyemail.innerHtml = _json['date_firma']['emailVanzator'];
      companytrezorerie.innerHtml = _json['date_firma']['contTrezVanzator'];
      companybanca.innerHtml = _json['date_firma']['contVanzator'];
      companyName.innerHtml = _json['date_firma']['numeVanzator'];
      // window.alert('Nume vanzator ' + _json['date_firma']['numeVanzator']);

      dataDoc1.innerHtml = dataFs;
      if (_json['data_aviz'] != null) {
        DateTime dataA = DateTime.parse(_json['data_aviz']);
        String dataFa = formatareData.format(dataA);
        String nrAviz = _json['nr_aviz'].toString();
        dataDoc2.innerHtml = dataFa + " cu avizul nr." + nrAviz;
      } else {
        dataDoc2.innerHtml = dataFs;
      }
      totalFact.innerHtml = cuPret == true ? _json['total_doc'] : '';
      double valDiscount = 0;
      double tvaDiscount = 0;
      String discount = '';

      if (tipDoc == 'fe') {
        bool hiden9 = false;
        bool hiden5 = false;
        totalFact.innerHtml = cuPret == true ? _json['total_fara_tva'] : '';
        totalGeneral.innerHtml = _json['total_doc'];
        totalTVA5.innerHtml = _json['tva_5'];
        totalTVA9.innerHtml = _json['tva_9'];
        totalTVA19.innerHtml = _json['tva_19'];

        if (totalTVA9.innerHtml == '0.00') {
          hiden9 = true;
        }
        if (totalTVA5.innerHtml == '0.00') {
          hiden5 = true;
        }
        rtva5.hidden = hiden5;
        rtva9.hidden = hiden9;
      }
      valDiscount = double.parse(_json['val_discount']);
      tvaDiscount = double.parse(_json['tva_discount']);
      discount = _json['discount'];
      //Incarc zona client
      clientName.innerHtml = _json['date_partener']['denumire'];
      clientAddress.innerHtml = _json['date_partener']['adresa'];
      clientcif.innerHtml = _json['date_partener']['cif'];
      delegat.innerHtml = _json['date_partener']['delegat'];
      clientcui.innerHtml = _json['date_partener']['cui'];
      ciDelegat.innerHtml = _json['date_partener']['ciNr'];
      masina.innerHtml = _json['date_partener']['masina'];
      ciPol.innerHtml = _json['date_partener']['ciPol'];
      nrLot.innerHtml = _json['date_partener']['nrLot'];

      //Zona tabel factura

      TableSectionElement tabel =
          querySelector('#tableBody') as TableSectionElement;
      TableRowElement row = TableRowElement();
      TableCellElement cell = TableCellElement();

      int j = 0;
      Map<String, dynamic> articol;

      List<dynamic> articoleFact = _json['continut'];
      int k;
      for (var i = 0; i < articoleFact.length; i++) {
        k = 0;
        //articoleFact este o lista. Fiecare articol este un sir de tip Json.
        // Pentru a o transforma in map trebuie intai sa folosesc encode, sa il recunoasca ca
        //json nu sir. Apoi cu decode din json il facem map

        var articolul = jsonEncode((articoleFact[i]));
        articol = jsonDecode(articolul);

        row = tabel.insertRow(-1); //insereaza rand in tabel
        cell = row.insertCell(k);
        cell.text = (i + 1).toString();
        cell.id = 'nrcrt';
        rule = '#nrcrt {text-align:center;}';
        styleSheet.insertRule(rule, 0);
        k = k + 1;
        cell = row.insertCell(k);
        articol['valabilitate'] =
            articol['valabilitate'] != null ? articol['valabilitate'] : "0";
        int _valab = int.parse(articol['valabilitate']);

        cell.text = _valab > 0
            ? articol['denumire'] +
                " (termen valabilitate:" +
                articol['valabilitate'] +
                " zile)"
            : articol['denumire']; // Aici introduc termen de valabilitate

        cell.id = 'denArt';
        rule = '#denArt {text-align:left;}';
        styleSheet.insertRule(rule, 0);
        k = k + 1;
        cell = row.insertCell(k);
        cell.text = articol['unit_mas'];
        cell.id = 'unMas';
        rule = '#unMas {text-align:center;}';
        styleSheet.insertRule(rule, 0);

        if (tipDoc == 'fe') {
          k = k + 1;
          cell = row.insertCell(k);
          cell.text = articol['ctva'];
          cell.id = 'cotaT';
          rule = '#cotaT {text-align:center;}';
          styleSheet.insertRule(rule, 0);
        }
        k = k + 1;
        cell = row.insertCell(k);
        cell.text = articol['cantitate'];
        cell.id = 'uncant';
        rule = '#uncant {text-align:center;}';
        styleSheet.insertRule(rule, 0);
        k = k + 1;
        cell = row.insertCell(k);
        cell.text = cuPret == true ? articol['pret'] : '';
        cell.id = 'pretArt';
        rule = '#pretArt {text-align:right;}';
        styleSheet.insertRule(rule, 0);

        k = k + 1;
        cell = row.insertCell(k);
        cell.text = cuPret == true ? articol['valoare'] : '';
        cell.id = 'valArt';
        rule = '#valArt {text-align:right;}';
        styleSheet.insertRule(rule, 0);
        if (tipDoc == 'fe') {
          k = k + 1;
          cell = row.insertCell(k);
          cell.text = articol['tva'];
          cell.id = 'tvaArt';
          rule = '#tvaArt {text-align:right}';
          styleSheet.insertRule(rule, 0);
        }
        //window.alert(articol['denumire']);
        j = i + 1;
      }
      j = j + 1;
      if (int.parse(discount) > 0) {
        row = tabel.insertRow(-1); //insereaza rand in tabel

        cell = row.insertCell(0);
        cell.text = j.toString();
        cell.id = 'crtDisco';
        rule = '#crtDisco {text-align:center;}';
        styleSheet.insertRule(rule, 0);
        cell = row.insertCell(1);
        cell.text = 'Discount $discount %';
        cell.id = 'procDisco';
        rule = '#procDisco {text-align:left;}';
        styleSheet.insertRule(rule, 0);
        cell = row.insertCell(2);
        cell.text = '';
        cell = row.insertCell(3);
        cell.text = ' ';
        cell = row.insertCell(4);
        cell.text = ' ';
        if (tipDoc == 'fe') {
          cell = row.insertCell(5);
          cell.text = '';
          cell = row.insertCell(6);
          cell.text = '-' + valDiscount.toStringAsFixed(2);
          cell.id = 'valDisco';
          rule = '#valDisco {text-align:right;}';

          styleSheet.insertRule(rule, 0);
          cell = row.insertCell(7);
          cell.text = '-' + tvaDiscount.toStringAsFixed(2);
          cell.id = 'tvaDisco';
          rule = '#tvaDisco {text-align:right;}';
          styleSheet.insertRule(rule, 0);
        } else {
          cell = row.insertCell(5);
          cell.text = '-' + valDiscount.toStringAsFixed(2);
          cell.id = 'valDisco';
          rule = '#valDisco {text-align:right;}';
          styleSheet.insertRule(rule, 0);
        }
      }
    }
  }
}
