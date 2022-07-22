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

    void _clickFunction() {
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
            _discount('f');
          }
          //   window.alert("Factura fara tva=" + UBFFactura.totalFactFaraTva.toString());
//Rotunjeste totalul facturii, adica scapa de zecimalele in plus
          double _zecimale = (UBFFactura.totalFactura - UBFFactura.totalFactura.round()).abs();
          if (_zecimale < Global.zecimale) {
            //      window.alert("Zecimale=" + _zecimale.toString());
            UBFFactura.totalFactura = UBFFactura.totalFactura - _zecimale;
            //   window.alert("Total Factura zecimale incluse =" + UBFFactura.totalFactura.toString());
            UBFFactura.totalFactFaraTva = UBFFactura.totalFactFaraTva - _zecimale;
            // window.alert("Zecimale Fact fara tva=" + UBFFactura.totalFactFaraTva.toString());
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
          UBFClient.discount = UBFFactura.discount;
          if (UBFClient.discount! > 0) {
            _discount('a');
          }
          if (Global.operatie == false) {
            lf.loadIncarcareFact(tabelA, "serverFactura", "av", UBFFactura(), "c");
          } else {
            lf.loadIncarcareFact(tabelA, "serverFactura", "av", UBFFactura(), "u");
          }
        }
      }
      //-------------------
    }

    void apasareTasta(KeyboardEvent e) {
      if (e.keyCode == KeyCode.ENTER) {
        //     _clickFunction();
        e.preventDefault(); //previne restart-ul cand se apasa enter in casuta de cautare

        //e.stopImmediatePropagation();
      }
    }

    document.onKeyPress.listen(apasareTasta);
    _btnOK.onClick.listen((e) async {
      _clickFunction();
    });
  }

  static void _discount(String tipDocument) {
    if (tipDocument == 'f') {
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
    } else {
      int? discount = UBFClient.discount;

      UBFFactura.discount = discount!;
      //  window.alert("Total factura inainte de calcule: " + UBFFactura.totalFactura.toString());
      if (Global.operatie == false) {
        UBFFactura.totalFactura = UBFFactura.totalFactFaraTva;
      }
      UBFFactura.valDiscount = UBFFactura.totalFactura * discount / 100;
      // window.alert("Total aviz = " + UBFFactura.totalFactura.toString() + " Total discount = " + UBFFactura.valDiscount.toString());
      UBFFactura.totalFactura = UBFFactura.totalFactura - UBFFactura.valDiscount;

      UBFFactura.tvaDiscount = UBFFactura.tva19 * discount / 100;
      UBFFactura.tva19 = UBFFactura.tva19 - UBFFactura.tvaDiscount;
      UBFFactura.tvaDiscount = UBFFactura.tva9 * discount / 100;
      UBFFactura.tva9 = UBFFactura.tva9 - UBFFactura.tvaDiscount;
      UBFFactura.tvaDiscount = UBFFactura.tva * discount / 100;
      UBFFactura.tva = UBFFactura.tva - UBFFactura.tvaDiscount;
      UBFFactura.totalFactFaraTva = UBFFactura.totalFactura - UBFFactura.tva;
    }
  }
}
