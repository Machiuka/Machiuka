import 'dart:html';
import '../clase/load_detalii.dart';
import 'formular_raportare.dart';
import 'formular_meniu.dart';
import 'cautare_factura.dart';

class LivrareMeniu {
  static void livrareMeniu() async {
    Element _divTopNav = querySelector('#top_nav') as Element;
    _divTopNav.hidden = true;
    LoadDetalii.incarcFormular('html/livrare_nav.html');
    await Future.delayed(const Duration(milliseconds: 50));

    Element _btnFacturi = querySelector('#btnFacturi') as Element;
    Element _btnAvize = querySelector('#btnAvize') as Element;
    Element _btnAviz2Fact = querySelector('#btnAviz2Fact') as Element;
    Element _btnNir = querySelector('#btnNir') as Element;
    Element _btnRaport = querySelector('#btnRaport') as Element;
    Element _btnBack = querySelector('#btnBack') as Element;
    Element _divLivrariNav = querySelector('#livrare_nav') as Element;

    _btnFacturi.onClick.listen((e) {
      _divLivrariNav.remove();
      FormularMeniu.formularMeniu('FACTURA');
    });
    _btnAvize.onClick.listen((e) {
      _divLivrariNav.remove();
      FormularMeniu.formularMeniu('AVIZ');
    });
    _btnAviz2Fact.onClick.listen((e) {
      _divLivrariNav.remove();
      FormularMeniu.formularAviz2Fact('Aviz2Fact');
    });
    _btnNir.onClick.listen((e) {
      _divLivrariNav.remove();
      FormularMeniu.formularNir('NIR');
    });
    _btnRaport.onClick.listen((e) {
      _divLivrariNav.remove();
      bool intern = true;

      intern = window.confirm("Raport livrari catre clienti? Ok, pt confirmare / Cancel pt livrari catre gestiuni");

      FormularRaportare.formular(intern);
    });

    _btnBack.onClick.listen((e) {
      _divLivrariNav.remove();

      window.location.reload(); //echivalent cu refresh pagina
      LoadDetalii.incarcFormular('html/top_nav.html');
    });
  }
}
