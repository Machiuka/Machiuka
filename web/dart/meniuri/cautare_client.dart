import 'dart:html';
import '../clase/load_client.dart';
import '../clase/load_detalii.dart';

class CautareClient {
  static void cautareClient(String crud) async {
    //Se foloseste atat la cautare cat si la actualizare si stergere client

    LoadClient lc = LoadClient();

    //  FormElement _formDetalii = querySelector("#formDetalii") as FormElement;
    LoadDetalii.incarcFormular('html/form_cautare.html');
    await Future.delayed(const Duration(milliseconds: 50));

    Element _btnOK = querySelector('#btnOK') as Element;
    FormElement _formCautare = querySelector('#formCautare') as FormElement;

    Element titluDetalii = querySelector('#titluDetalii') as Element;
    titluDetalii.innerHtml = 'Cautare Client';

    InputElement _txtCautare = querySelector("#txtCautare") as InputElement;

    _btnOK.onClick.listen((e) {
      String? caut = _txtCautare.value;
      //---------------------------------------

      if (caut != null) {
        _formCautare.remove();

        lc.loadClient(crud, caut, 'tbl_parteneri', 'serverCautare');

        //echivalent cu refresh pagina
      } else {
        window.location.reload(); //echivalent cu refresh pagina
      }
    });
  }
}
