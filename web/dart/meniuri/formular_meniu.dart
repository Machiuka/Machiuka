import 'dart:html';
import '../clase/load_detalii.dart';
import '../clase/load_factura.dart';
import 'cautare_reteta.dart';
import '../clase/local_storage.dart';
import 'adaugare_reteta.dart';
import 'stergere_reteta.dart';
import 'cautare_cumparator.dart';
import 'cautare_factura.dart';

class FormularMeniu {
  static void formularNir(String titlu) async {
    Element _divTopNav = querySelector('#top_nav') as Element;
    _divTopNav.remove();
    LoadDetalii.incarcFormular('html/form_detalii.html');
    await Future.delayed(const Duration(milliseconds: 50));

    Element _btnCautare = querySelector('#btnCautare') as Element;
    Element _btnAdaugare = querySelector('#btnAdaugare') as Element;
    Element _btnModificare = querySelector('#btnModificare') as Element;
    Element _divModificare = querySelector('#divModificare') as Element;
    Element _btnStergere = querySelector('#btnStergere') as Element;
    Element _titluH1 = querySelector('#titluDetalii') as Element;

    _titluH1.innerHtml = titlu;
    _btnAdaugare.hidden = true;
    _btnModificare.hidden = true;
    _btnStergere.hidden = true;
    _btnCautare.onClick.listen((e) {
      CautareFactura.cautareFactura(titlu);
    });
  }

  static void formularAviz2Fact(String titlu) async {
    Element _divTopNav = querySelector('#top_nav') as Element;
    _divTopNav.remove();
    LoadDetalii.incarcFormular('html/form_detalii.html');
    await Future.delayed(const Duration(milliseconds: 50));

    Element _btnCautare = querySelector('#btnCautare') as Element;
    Element _btnAdaugare = querySelector('#btnAdaugare') as Element;
    Element _btnModificare = querySelector('#btnModificare') as Element;
    Element _divModificare = querySelector('#divModificare') as Element;
    Element _btnStergere = querySelector('#btnStergere') as Element;
    Element _titluH1 = querySelector('#titluDetalii') as Element;

    _titluH1.innerHtml = "Generare Factura pe baza Aviz Expeditie";
    _btnAdaugare.hidden = true;
    _btnModificare.hidden = true;
    _btnStergere.hidden = true;
    _btnCautare.onClick.listen((e) {
      CautareFactura.cautareFactura(titlu);
    });
  }

  static void formularMeniu(String titlu) async {
    LocalStorage local = LocalStorage();
    Element _divTopNav = querySelector('#top_nav') as Element;
    _divTopNav.remove();
    LoadDetalii.incarcFormular('html/form_detalii.html');
    await Future.delayed(const Duration(milliseconds: 50));

    Element _btnCautare = querySelector('#btnCautare') as Element;
    Element _btnAdaugare = querySelector('#btnAdaugare') as Element;
    Element _btnModificare = querySelector('#btnModificare') as Element;
    Element _btnStergere = querySelector('#btnStergere') as Element;
    Element _titluH1 = querySelector('#titluDetalii') as Element;

    String tabelF = "tbl_facturi" + local.cauta('sufix').toString();
    String tabelA = "tbl_avize" + local.cauta('sufix').toString();
    //window.alert(tabelA + " FM " + tabelF);
    // if (titlu == 'FACTURA' || titlu == 'AVIZ') _divModificare.hidden = true;
    LoadFactura lf = LoadFactura();
    bool confirm = false;

    _titluH1.innerHtml = titlu;

    _btnCautare.onClick.listen((e) {
      if (titlu == "RETETAR") {
        CautareReteta.cautareReteta(titlu);
      }
      if (titlu == "FACTURA" || titlu == "AVIZ") {
        CautareFactura.cautareFactura(titlu);
      }
    });
    _btnAdaugare.onClick.listen((e) {
      if (titlu == "RETETAR") {
        AdaugareReteta.adaugareReteta("Adauga Reteta", "tbl_produse", "serverAdaugReteta");
      }
      if (titlu == "FACTURA" || titlu == "AVIZ") {
        CautareCumparator.cautareCumparator(titlu);
      }
    });

    _btnModificare.onClick.listen((e) {
      if (titlu == "RETETAR") {
        CautareReteta.cautareReteta('MODIFICARE PRODUS FINIT');
      }
      if (titlu == "FACTURA" || titlu == "AVIZ") {
        CautareFactura.cautareFactura(titlu, true);
      }
    });

    _btnStergere.onClick.listen((e) {
      if (titlu == "RETETAR") {
        StergereReteta.stergere("Sterge Reteta", "tbl_produse", "serverCautStergReteta");
      }
      if (titlu == "FACTURA") {
        //StergereReteta.stergere("Sterge Reteta", "tbl_produse", "serverCautStergReteta");
        confirm = window.confirm("Ultima factura va fi stearsa. Ok, pt confirmare, Cancel pt anulare");
        if (confirm) lf.loadStergere('fe', tabelF, 'serverFactura');
      }
      if (titlu == "AVIZ") {
        confirm = window.confirm("Ultimul aviz va fi sters. Ok, pt confirmare, Cancel pt anulare");
        if (confirm) lf.loadStergere('av', tabelA, 'serverFactura');
      }
    });
  }
}
