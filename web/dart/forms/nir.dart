import 'dart:html';
import '../clase/load_detalii.dart';
import 'dart:convert';
import '../clase/css.dart';
import 'package:intl/intl.dart';

class NIR {
  static void afisNir(String tipDoc, Map<String, dynamic> _json) async {
    final styleSheet = document.styleSheets![0] as CssStyleSheet;
    String rule;

    if (_json['nr_nir'] == null) {
      window.alert('NIR Inexistent!!!');
      window.location.reload();
    } else {
      CSS.aplicaCSS("css/invoice.css");

      // ignore: unnecessary_null_comparison
      String formular = 'html/nir.html';

      LoadDetalii.incarcFormular(formular);
      await Future.delayed(const Duration(milliseconds: 350));

      //Zona Vanzator
      LabelElement webpage = querySelector('#webpage') as LabelElement;
      LabelElement companyName = querySelector('#company_name') as LabelElement;
      LabelElement companyAddress = querySelector('#company_address') as LabelElement;
      LabelElement companycif = querySelector('#company_cif') as LabelElement;
      LabelElement companycui = querySelector('#company_cui') as LabelElement;
      LabelElement companytel = querySelector('#company_tel') as LabelElement;
      LabelElement companyemail = querySelector('#company_email') as LabelElement;
      LabelElement companybanca = querySelector('#company_banca') as LabelElement;
      LabelElement companytrezorerie = querySelector('#company_trezorerie') as LabelElement;
      SpanElement dataDoc1 = querySelector('.dataDoc1') as SpanElement;
      SpanElement dataDoc2 = querySelector('.dataDoc2') as SpanElement;

      SpanElement totalFact = querySelector('#totalFact') as SpanElement;
      LabelElement nrNir = querySelector('#nr_nir') as LabelElement;
      LabelElement nrFact = querySelector('#cod_doc') as LabelElement;

//Zona Client
      LabelElement clientName = querySelector('#client_name') as LabelElement;
      LabelElement clientAddress = querySelector('#client_address') as LabelElement;
      LabelElement clientcif = querySelector('#client_cif') as LabelElement;
      LabelElement clientcui = querySelector('#client_cui') as LabelElement;

//*************** */

      final DateFormat formatareData = DateFormat('dd.M.yyyy');
      DateTime dataF = DateTime.parse(_json['data_doc']);
      String dataFs = formatareData.format(dataF);

//Incarc zona Vanzator
      webpage.innerHtml = _json['date_firma']['webVanzator'];
      nrNir.innerHtml = _json['nr_nir'].toString();
      nrFact.innerHtml = _json['cod_doc'].toString();

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
      dataDoc2.innerHtml = dataFs;
      // totalFact.innerHtml = _json['total_fara_tva'];
      totalFact.innerHtml = _json['total_doc'];

      //Incarc zona client
      clientName.innerHtml = _json['date_partener']['denumire'];
      clientAddress.innerHtml = _json['date_partener']['adresa'];
      clientcif.innerHtml = _json['date_partener']['cif'];

      clientcui.innerHtml = _json['date_partener']['cui'];

      //Zona tabel factura
      //Map<String, dynamic> articoleFact = _json['continut'];
      TableSectionElement tabel = querySelector('#tableBody') as TableSectionElement;
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
        //cell.text = articol['denumire'] + " (termen valabilitate:" + articol['valabilitate'] + " zile)"; // Aici introduc termen de valabilitate
        cell.text = articol['denumire'];
        cell.id = 'denArt';
        rule = '#denArt {text-align:left;}';
        styleSheet.insertRule(rule, 0);
        k = k + 1;
        cell = row.insertCell(k);
        cell.text = articol['unit_mas'];
        cell.id = 'unMas';
        rule = '#unMas {text-align:center;}';
        styleSheet.insertRule(rule, 0);

        k = k + 1;
        cell = row.insertCell(k);
        cell.text = articol['cantitate'];
        cell.id = 'uncant';
        rule = '#uncant {text-align:center;}';
        styleSheet.insertRule(rule, 0);
        k = k + 1;
        cell = row.insertCell(k);
        cell.text = articol['cantitate'];
        cell.id = 'reccant';
        rule = '#reccant {text-align:center;}';
        styleSheet.insertRule(rule, 0);
        k = k + 1;
        cell = row.insertCell(k);
        cell.text = articol['pret'];
        cell.id = 'pretArt';
        rule = '#pretArt {text-align:right;}';
        styleSheet.insertRule(rule, 0);

        k = k + 1;
        cell = row.insertCell(k);
        cell.text = articol['valoare'];
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
    }
  }
}
