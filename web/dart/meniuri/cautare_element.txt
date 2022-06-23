import 'dart:html';
import '../clase/load_detalii.dart';
import '../clase/global.dart';
import '../clase/ubf_client.dart';
import '../clase/ubf_document.dart';
import '../clase/ubf_factura.dart';
import '../clase/load_factura.dart';
import '../clase/local_storage.dart';

class CautareElement {
  static void cautareElement(String titlu, [bool operatie = false]) async {
    //Element _divTopNav = querySelector('#top_nav') as Element;
    //_divTopNav.hidden = true;
    //  window.alert(operatie.toString());

    if (operatie == true) {
      Global.operatie = true;
    }
    // FormElement _formDetalii = querySelector("#formDetalii") as FormElement;
    LocalStorage local = LocalStorage();
    UBFFactura.operator = local.cauta('utilizator')!;

    LoadDetalii.incarcFormular('html/form_cautare.html');
    await Future.delayed(const Duration(milliseconds: 50));

    if (titlu == 'FACTURA' || titlu == 'AVIZ') {
      Element titluDetalii = querySelector('#titluDetalii') as Element;
      titluDetalii.innerHtml = 'Cautare produs finit';
    }

    Element _btnOK = querySelector('#btnOK') as Element;
    FormElement _formCautare = querySelector('#formCautare') as FormElement;

    //_formDetalii.replaceWith(_formCautare);

    InputElement _txtCautare = querySelector("#txtCautare") as InputElement;

    _btnOK.onClick.listen((e) async {
      LoadDetalii ld = LoadDetalii();
      LoadFactura lf = LoadFactura();

      String tabelF = "tbl_facturi" + local.cauta('sufix').toString();
      String tabelA = "tbl_avize" + local.cauta('sufix').toString();
      //window.alert(tabelA + " CE " + tabelF);

      if (titlu == "RETETAR") {
        //Aici se ocupa de butonul Retetar
        String? caut = _txtCautare.value;
        if (caut != '') {
          //sterg formularul pentru a nu se adauga cautare peste cautare

          ld.loadElement(caut!, "tbl_mp", "serverCautare");
        } else {
          int lungime = Global.continut.length;
          if (lungime > 1) {
            Global.continut = Global.continut.substring(0, lungime - 1);

            UBFDocument.continutDoc = Global.continut;
          }
          Global.continut = '';
          LoadDetalii.incarcFormular('html/form_document.html'); //Este cerut la raspuns_tabel
          await Future.delayed(const Duration(milliseconds: 50));
          //   window.alert(Global.continut);
          _formCautare.remove();

          ld.loadIncarcareDoc("tbl_produse", "serverAdaugReteta", "rt", UBFDocument());
        }
      }
      if (titlu == 'FACTURA') {
        String? caut = _txtCautare.value;
        if (caut != '') {
          //sterg formularul pentru a nu se adauga cautare peste cautare

          lf.loadArticol('fe', caut!, "tbl_produse", "serverCautare");
        } else {
          // _formCautare.remove();

          UBFClient.discount = UBFFactura.discount;

          //calculeaza discount

          //fiindca deja am incarcat discounturile din invoice_body.dart cand operatie este true adica actualizare
          if (UBFClient.discount! > 0) {
            int? discount = UBFClient.discount;
            UBFFactura.discount = discount!;
            UBFFactura.valDiscount = UBFFactura.totalFactFaraTva * discount / 100;
            UBFFactura.totalFactFaraTva = UBFFactura.totalFactFaraTva - UBFFactura.valDiscount;
            UBFFactura.tvaDiscount = UBFFactura.tva19 * discount / 100;
            UBFFactura.tva19 = UBFFactura.tva19 - UBFFactura.tvaDiscount;
            UBFFactura.tvaDiscount = UBFFactura.tva9 * discount / 100;
            UBFFactura.tva9 = UBFFactura.tva9 - UBFFactura.tvaDiscount;
            UBFFactura.tvaDiscount = UBFFactura.tva * discount / 100;
            UBFFactura.tva = UBFFactura.tva - UBFFactura.tvaDiscount;
            UBFFactura.totalFactura = UBFFactura.totalFactFaraTva + UBFFactura.tva;
          }

          // window.alert(Global.operatie.toString());
          _formCautare.remove();
          if (Global.operatie == false) {
            UBFFactura.termenPlata = UBFClient.tPlata!;
            lf.loadIncarcareFact(tabelF, "serverFactura", "fe", UBFFactura(), "c");
          } else {
            lf.loadIncarcareFact(tabelF, "serverFactura", "fe", UBFFactura(), "u");
          }
        }
      }
      //----------------------
      if (titlu == 'AVIZ') {
        String? caut = _txtCautare.value;
        if (caut != '') {
          //sterg formularul pentru a nu se adauga cautare peste cautare

          lf.loadArticol('av', caut!, "tbl_produse", "serverCautare");
        } else {
          _formCautare.remove();

          if (Global.operatie == false) {
            lf.loadIncarcareFact(tabelA, "serverFactura", "av", UBFFactura(), "c");
          } else {
            lf.loadIncarcareFact(tabelA, "serverFactura", "av", UBFFactura(), "u");
          }
        }
      }
      //-------------------
    });
  }
}
