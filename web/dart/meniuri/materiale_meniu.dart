import 'dart:html';
import '../clase/load_detalii.dart';

class MaterialeMeniu {
  static void materialeMeniu() async {
    Element _divTopNav = querySelector('#top_nav') as Element;
    _divTopNav.hidden = true;
    LoadDetalii.incarcFormular('html/materiale_nav.html');
    await Future.delayed(const Duration(milliseconds: 50));

    Element _btnCautare = querySelector('#btnCautare') as Element;
    Element _btnAdaugare = querySelector('#btnAdaugare') as Element;
    Element _btnModificare = querySelector('#btnModificare') as Element;
    Element _btnStergere = querySelector('#btnStergere') as Element;
    Element _btnInapoi = querySelector('#btnInapoi') as Element;
    Element _divMaterialeNav = querySelector('#materiale_nav') as Element;

    _btnCautare.onClick.listen((e) {
      window.alert('Apasat buton Cautare');
    });
    _btnAdaugare.onClick.listen((e) {
      window.alert('Apasat buton Adaugare');
    });

    _btnModificare.onClick.listen((e) {
      window.alert('Apasat buton Modif');
    });

    _btnStergere.onClick.listen((e) {
      window.alert('Apasat buton Stergere');
    });
    _btnInapoi.onClick.listen((e) {
      _divMaterialeNav.hidden = true;

      window.location.reload(); //echivalent cu refresh pagina
      LoadDetalii.incarcFormular('html/top_nav.html');
    });
  }
}
