import 'dart:html';
import '../clase/ubf_factura.dart';
import '../clase/load_detalii.dart';
import 'dart:convert';
import '../clase/css.dart';
import 'package:intl/intl.dart';
import '../clase/global.dart';
import '../clase/local_storage.dart';
import '../meniuri/cautare_element.dart';

class InvoiceBody {
  //Afiseaza articolele din ultima factura pentru a fi modificate
  static void afisFactura(String tipDoc, Map<String, dynamic> _json) async {
    final styleSheet = document.styleSheets![0] as CssStyleSheet;

    String rule;
    int nr_art = 0;
    LocalStorage local = LocalStorage();

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

      LoadDetalii.incarcFormular(formular);
      await Future.delayed(const Duration(milliseconds: 350));

      //Zona Vanzator
      DivElement divFactura = querySelector('#divFactura') as DivElement;
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
      SpanElement totalTVA5 = querySelector('#totalTVA5') as SpanElement;
      SpanElement totalTVA19 = querySelector('#totalTVA19') as SpanElement;
      SpanElement totalTVA9 = querySelector('#totalTVA9') as SpanElement;
      SpanElement totalFact = querySelector('#totalFact') as SpanElement;
      SpanElement tPlata = querySelector('#tPlata') as SpanElement;
      SpanElement nrLot = querySelector('#nrLot')
          as SpanElement; //Nr lotului din care fac parte produsele
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

      final DateFormat formatareData = DateFormat('dd.M.yyyy');
      DateTime dataF = DateTime.parse(_json['data_doc']);
      String dataFs = formatareData.format(dataF);

      int termenPlata = int.parse(_json['termen_plata']);
      DateTime dataP = dataF.add(new Duration(days: termenPlata));
      String dataFp = formatareData.format(dataP);
      tPlata.innerHtml = _json['termen_plata'];
      dataDoc3.innerHtml = dataFp;

//Incarc zona Vanzator
      webpage.innerHtml = _json['date_firma']['webVanzator'];
      if (tipDoc == 'fe') {
        nrFact.innerHtml = (UBFFactura.prefix + _json['cod_doc'].toString());
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
      dataDoc2.innerHtml = dataFs;
      if (tipDoc == 'fe') {
        totalFact.innerHtml = cuPret == true ? _json['total_fara_tva'] : '';
      } else {
        totalFact.innerHtml = cuPret == true ? _json['total_doc'] : '';
      }
      double valDiscount = 0;
      double tvaDiscount = 0;
      String discount = '';

      if (tipDoc == 'fe') {
        totalGeneral.innerHtml = _json['total_doc'];
        totalTVA5.innerHtml = _json['tva_5'];
        totalTVA9.innerHtml = _json['tva_9'];
        totalTVA19.innerHtml = _json['tva_19'];
        rtva5.hidden = _json['tva_5'] != null ? false : true;
        rtva9.hidden = _json['tva_9'] != null ? false : true;
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
      //Map<String, dynamic> articoleFact = _json['continut'];
      TableSectionElement tabel =
          querySelector('#tableBody') as TableSectionElement;
      TableRowElement row = TableRowElement();
      TableCellElement cell = TableCellElement();

      int j = 0;
      Map<String, dynamic> articol;

      List<dynamic> articoleFact = _json['continut'];
      nr_art = articoleFact.length;
      for (var i = 0; i < nr_art; i++) {
        int k = 0;
        k = 0;
        //articoleFact este o lista. Fiecare articol este un sir de tip Json.
        // Pentru a o transforma in map trebuie intai sa folosesc encode, sa il recunoasca ca
        //json nu sir. Apoi cu decode din json il facem map

        var articolul = jsonEncode(articoleFact[i]);
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
        InputElement art =
            InputElement(); // daca nu este definit aici apare doar o data
        art.id = 'uncant$i';
        art.className = 'cantit';
        art.value = articol['cantitate'];
        rule =
            '.cantit {text-align:center; border:none; type:number;  width: 50%;}';
        styleSheet.insertRule(rule, 0);
        cell.children.add(art);

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
      webpage.onClick.listen((e) {
        CSS.eliminaCSS("css/invoice.css");

        int _discount = int.parse(_json['discount'].toString());

        double _cantit = 0;
        List lista = [];
        for (var i = 0; i < nr_art; i++) {
          InputElement _elem = querySelector('#uncant$i') as InputElement;
          _cantit = double.parse(_elem.value.toString());

          lista.add(_cantit);

          //    window.alert("Nr articole= " + lista[i].toString());
        }
        _modificare(articoleFact, lista, tipDoc, _discount);
        int termenPlata = int.parse(_json['termen_plata']);
        UBFFactura.termenPlata = termenPlata;
        UBFFactura.achitata = termenPlata > 0 ? 0 : 1;
        UBFFactura.dateCumparator = _json['date_partener'];
        UBFFactura.nrFact = int.parse(_json['cod_doc']);
        UBFFactura.adaos =
            _json['adaos'] != null ? int.parse(_json['adaos']) : 0;
        UBFFactura.dataFact = _json['data_doc'];
        UBFFactura.nrNir == _json['nr_NIR'];
        Global.operator = local.cauta('utilizator')!;
        divFactura.remove();
        if (tipDoc == "fe") {
          CautareElement.cautareElement("FACTURA", true);
        } else {
          CautareElement.cautareElement("AVIZ", true);
        }
      });
    }
  }

  static void _modificare(
      List<dynamic> articoleF, List cant, String tipD, int discount) {
    UBFFactura.articoleFactura = "";
    Map<String, dynamic> _articol;
    double pret = 0;
    double tvaProdus = 0;

    double tva = 0;
    double totalCuTva = 0;
    double totalFaraTva = 0;
    double totalTva = 0;
    double totalTvaDiscount = 0;
    double totalDiscount = 0;

    double valDiscount = 0;
    double tvaDiscount = 0;
    double valFaraTva = 0;
    double valCuTva = 0;
    double tva19 = 0;
    double tva9 = 0;
    double tva5 = 0;
    double totalTva19 = 0;
    double totalTva9 = 0;
    double totalTva5 = 0;
    int ctva = 0;

    int _nr_art = articoleF.length;
    for (var i = 0; i < _nr_art; i++) {
      var _articolul = jsonEncode((articoleF[i]));
      _articol = jsonDecode(_articolul);
      _articol['cantitate'] = cant[i];
      if (cant[i] > 0) {
        ctva = int.parse(_articol['ctva'].toString());

        pret = double.parse(_articol['pret']);
        //  window.alert('Pret produs=' + pret.toString());
        if (tipD == 'fe') {
          tvaProdus = double.parse(
              (pret * ctva / 100 * Global.precision).toStringAsFixed(2));

          valFaraTva = pret * cant[i];
          tva = tvaProdus * cant[i] / Global.precision;
          valCuTva = valFaraTva + tva;
        } else {
          tvaProdus = double.parse(
              (pret * ctva / (100 + ctva) * Global.precision)
                  .toStringAsFixed(2));

          valCuTva = pret * cant[i];
          tva = tvaProdus * cant[i] / Global.precision;
          valFaraTva = valCuTva - tva;
          valFaraTva = valCuTva - tva;
          // window.alert('Tva produs=' + tvaProdus.toString() + ' cant=' + cant.toString() + ' TVA=' + tva.toString());
          // window.alert('Valftva=' + valFaraTva.toString() + ' ValcuTva=' + valCuTva.toString());

        }

//Incarca articole
        String _cantitate = cant[i].toString();
        UBFFactura.articol['valabilitate'] = _articol['valabilitate'];
        UBFFactura.articol['denumire'] = _articol['denumire'];
        UBFFactura.articol['codElem'] = _articol['codElem'];
        UBFFactura.articol['unit_mas'] = _articol['unit_mas'];
        UBFFactura.articol['cantitate'] = _cantitate;
        UBFFactura.articol['ctva'] = ctva.toString();
        UBFFactura.articol['tva'] = tva.toStringAsFixed(2);
        UBFFactura.articol['pret'] = pret.toStringAsFixed(2);
        if (tipD == 'fe') {
          UBFFactura.articol['valoare'] = valFaraTva.toStringAsFixed(2);
        } else {
          UBFFactura.articol['valoare'] = valCuTva.toStringAsFixed(2);
        }
        UBFFactura.articoleFactura =
            UBFFactura.articoleFactura + jsonEncode(UBFFactura.articol) + ',';

//Calculeaza totaluri

        if (ctva == 19) {
          tva19 = tva;
        } else if (ctva == 9) {
          tva9 = tva;
        } else {
          tva5 = tva;
        }

        totalFaraTva = totalFaraTva + valFaraTva;
        totalTva = totalTva + tva;
        totalCuTva = totalCuTva + valCuTva;
        totalTva19 = totalTva19 + tva19;
        totalTva9 = totalTva9 + tva9;
        totalTva5 = totalTva5 + tva5;
        //    window.alert("valFaraTva= " + totalFaraTva.toString() + " valcu TVA = " + totalCuTva.toString());

        // window.alert(totalTva.toString() + ' tva9=' + totalTva9.toString());
      }
    }
    //adauga valori factura

    UBFFactura.totalFactFaraTva = totalFaraTva;

    UBFFactura.tva19 = totalTva19;
    UBFFactura.tva5 = totalTva5;
    UBFFactura.tva9 = totalTva9;
    UBFFactura.tva = totalTva5 + totalTva9 + totalTva19;
    UBFFactura.totalFactura = totalCuTva;
    UBFFactura.discount = discount;
    //Rotunjeste totalul facturii, adica scapa de zecimalele in plus

    double _zecimale =
        (UBFFactura.totalFactura - UBFFactura.totalFactura.round()).abs();

    if (_zecimale < Global.zecimale) {
      UBFFactura.totalFactura = UBFFactura.totalFactura - _zecimale;
      UBFFactura.totalFactFaraTva = UBFFactura.totalFactFaraTva - _zecimale;
    }
  }
}
