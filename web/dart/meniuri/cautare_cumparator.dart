import 'dart:html';
import '../clase/load_detalii.dart';
import '../clase/load_factura.dart';

class CautareCumparator {
  static void cautareCumparator(String titlu) async {
    //Se foloseste atat la cautare cat si la actualizare
    FormElement _formDetalii = querySelector("#formDetalii") as FormElement;
    LoadDetalii.incarcFormular('html/form_cautare.html');
    await Future.delayed(const Duration(milliseconds: 50));

    Element _btnOK = querySelector('#btnOK') as Element;
    FormElement _formCautare = querySelector('#formCautare') as FormElement;
    _formDetalii.replaceWith(_formCautare);

    Element titluDetalii = querySelector('#titluDetalii') as Element;
    titluDetalii.innerHtml = 'Cautare Client';

    InputElement _txtCautare = querySelector("#txtCautare") as InputElement;

    _btnOK.onClick.listen((e) {
      String? caut = _txtCautare.value;
      //---------------------------------------
      if (titlu == "FACTURA") {
        //Aici se ocupa de butonul Adaugare factura

        if (caut != null) {
          _formCautare.replaceWith(_formDetalii); //sterg formularul pentru a nu se adauga cautare peste cautare
          LoadFactura lf = LoadFactura();
          lf.loadClient('fe', caut, 'tbl_parteneri', 'serverCautare');
          //AdaugareFactura.adaugareFactura(caut, "tbl_parteneri", "serverCautare");
        } else {
          window.location.reload(); //echivalent cu refresh pagina
        }
      }
//-------------------------
      if (titlu == "AVIZ") {
        //Aici se ocupa de butonul Adaugare avize

        if (caut != null) {
          _formCautare.replaceWith(_formDetalii); //sterg formularul pentru a nu se adauga cautare peste cautare
          LoadFactura lf = LoadFactura();
          lf.loadClient('av', caut, 'tbl_parteneri', 'serverCautare');
          //AdaugareFactura.adaugareFactura(caut, "tbl_parteneri", "serverCautare");
        } else {
          window.location.reload(); //echivalent cu refresh pagina
        }
      }
//-----------------------
    });
  }
}
