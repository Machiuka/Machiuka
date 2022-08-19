import 'dart:html';
import '../clase/load_detalii.dart';
import '../forms/form_client.dart';
import 'cautare_client.dart';

class AdminClienti {
  static void administrareClienti() async {
    LoadDetalii.incarcFormular('html/admin_clienti.html');
    await Future.delayed(const Duration(milliseconds: 50));

    Element _btnCautareClient = querySelector('#btnCautareClient') as Element;
    Element _btnCreareClient = querySelector('#btnCreareClient') as Element;
    Element _btnClientInapoi = querySelector('#btnClientInapoi') as Element;
    Element _btnStergClient = querySelector('#btnStergereClient') as Element;
    Element _btnModifClient = querySelector('#btnModifClient') as Element;
    DivElement _adminClienti = querySelector('#admin_clienti') as DivElement;

    _btnCreareClient.onClick.listen((e) {
      _adminClienti.remove();
      FormClient.formClient();
    });
    _btnCautareClient.onClick.listen((e) {
      _adminClienti.remove();
      CautareClient.cautareClient('r');
    });
    _btnModifClient.onClick.listen((e) {
      _adminClienti.remove();
      CautareClient.cautareClient('u');
    });

    _btnStergClient.onClick.listen((e) {
      _adminClienti.remove();
      CautareClient.cautareClient('d');
    });

    _btnClientInapoi.onClick.listen((e) {
      _adminClienti.remove();

      window.location.reload(); //echivalent cu refresh pagina
      LoadDetalii.incarcFormular('html/top_nav.html');
    });
  }
}
