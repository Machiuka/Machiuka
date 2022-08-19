import 'dart:html';
import '../clase/load_detalii.dart';
import 'actualizare_reteta.dart';

class CautareReteta {
  static void cautareReteta(String titlu) async {
    //Se foloseste atat la cautare cat si la actualizare
    FormElement _formDetalii = querySelector("#formDetalii") as FormElement;
    LoadDetalii.incarcFormular('html/form_cautare.html');
    await Future.delayed(const Duration(milliseconds: 50));

    Element _btnOK = querySelector('#btnOK') as Element;
    FormElement _formCautare = querySelector('#formCautare') as FormElement;
    _formDetalii.replaceWith(_formCautare);

    InputElement _txtCautare = querySelector("#txtCautare") as InputElement;

    _btnOK.onClick.listen((e) {
      String? caut = _txtCautare.value;
      if (titlu == "RETETAR") {
        //Aici se ocupa de butonul Retetar

        if (caut != null) {
          _formCautare.replaceWith(_formDetalii); //sterg formularul pentru a nu se adauga cautare peste cautare
          LoadDetalii ld = LoadDetalii();
          ld.loadInterogare(caut, "tbl_produse", "serverCautStergReteta", "servReteta");
        } else {
          window.location.reload(); //echivalent cu refresh pagina
        }
      } else if (titlu == 'MODIFICARE PRODUS FINIT') {
        if (caut != null) {
          _formCautare.replaceWith(_formDetalii); //sterg formularul pentru a nu se adauga cautare peste cautare
          ActualizareReteta actualizareReteta = ActualizareReteta();
          actualizareReteta.actualizareReteta(caut, "tbl_produse", "serverCautStergReteta");
        } else {
          window.location.reload(); //echivalent cu refresh pagina
        }
      }
    });
  }
}
