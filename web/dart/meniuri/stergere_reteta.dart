import 'dart:html';
import '../clase/load_detalii.dart';

class StergereReteta {
  static void stergere(String titlu, String tabel, String server) async {
    //Element _divTopNav = querySelector('#top_nav') as Element;
    //_divTopNav.hidden = true;
    FormElement _formDetalii = querySelector("#formDetalii") as FormElement;
    LoadDetalii.incarcFormular('html/form_cautare.html');
    await Future.delayed(const Duration(milliseconds: 50));

    Element _btnOK = querySelector('#btnOK') as Element;
    FormElement _formCautare = querySelector('#formCautare') as FormElement;
    _formDetalii.replaceWith(_formCautare);

    InputElement _txtCautare = querySelector("#txtCautare") as InputElement;

    _btnOK.onClick.listen((e) async {
      _formCautare.replaceWith(_formDetalii);

      LoadDetalii ld = LoadDetalii();

      //if (titlu == "Sterge Reteta") {

      String? caut = _txtCautare.value;
      if (caut != '') {
        //sterg formularul pentru a nu se adauga cautare peste cautare

        ld.loadStergere(caut!, tabel, server);
      } else {
        window.location.reload(); //echivalent cu refresh pagina
      }
    });
  }
}
