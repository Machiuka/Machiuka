import 'dart:html';
import '../clase/load_detalii.dart';
import '../clase/load_factura.dart';
import '../clase/local_storage.dart';
import '../clase/global.dart';

class CautareFactura {
  static void cautareFactura(String titlu, [bool modificare = false]) async {
    //Se foloseste atat la cautare cat si la actualizare

    LocalStorage local = LocalStorage();
    FormElement _formDetalii = querySelector("#formDetalii") as FormElement;
    LoadDetalii.incarcFormular('html/form_cautare.html');
    await Future.delayed(const Duration(milliseconds: 50));

    Element _btnOK = querySelector('#btnOK') as Element;
    FormElement _formCautare = querySelector('#formCautare') as FormElement;
    _formDetalii.replaceWith(_formCautare);

    InputElement _txtCautare = querySelector("#txtCautare") as InputElement;
    String tabelF = "tbl_facturi" + local.cauta('sufix').toString();
    String tabelA = "tbl_avize" + local.cauta('sufix').toString();
    //String tabelN = "tbl_nir" + local.cauta('sufix').toString();
    //window.alert(tabelA + " CF " + tabelF);

    _btnOK.onClick.listen((e) {
      String? caut = _txtCautare.value;

      LoadFactura lf = LoadFactura();
      if (titlu == "FACTURA") {
        if (caut != null) {
          _formCautare.remove();

          lf.loadInterogare('fe', caut, tabelF, "serverFactura", modificare);
        } else {
          window.location.reload(); //echivalent cu refresh pagina
        }
      } else if (titlu == 'AVIZ') {
        if (caut != null) {
          _formCautare.remove();
          lf.loadInterogare('av', caut, tabelA, "serverFactura", modificare);
        } else {
          window.location.reload(); //echivalent cu refresh pagina
        }
      } else if (titlu == 'NIR') {
        if (caut != null) {
          _formCautare.remove();
          lf.loadInterogare("nir", caut, tabelA, "serverFactura");
        } else {
          window.location.reload(); //echivalent cu refresh pagina
        }
      }
    });
  }
}
