import 'dart:html';
import 'load_detalii.dart';
import 'tabelare.dart';

class RaspunsTabel {
  static void raspunsTabel(Map<String, dynamic> js) async {
    FormElement formDocument = querySelector('#formDocument') as FormElement;
    LoadDetalii.incarcFormular('html/form_tabel.html');
    await Future.delayed(const Duration(milliseconds: 50));
    FormElement formTabel = querySelector("#formTabel") as FormElement;
    Element titluTabel = querySelector("#titluTabel") as Element;
    Element btnInapoi = querySelector("#btnCCC") as Element;
    document.head!.append(StyleElement());
    final styleSheet = document.styleSheets![0] as CssStyleSheet;
    String rule;

    //window.alert(js['mesaj']);
    if (js['eroare'] == null) {
      //@keyframes blinker este definit in styles_formular.css
      rule = '#titluTabel {animation: blinker none;}';
      styleSheet.insertRule(rule, 0);
      titluTabel.innerHtml = "ADAUGARE REUSITA";
    } else {
      rule = '#titluTabel {animation: blinker 1s linear infinite;}';
      styleSheet.insertRule(rule, 0);
      titluTabel.innerHtml = "EROARE!!!";
    }
    Tabelare tabelul = Tabelare();

    formDocument.replaceWith(
        formTabel); //inlocuie formDetalii cu formTabel. Proprietatea hidden nu a functionat, iar remove() pierde metodele atasate butoanelor
    tabelul.adauga(js, 'tabelDetalii', 0);
    btnInapoi.onClick.listen((event) {
      window.location.reload(); //echivalent cu refresh pagina
    });
  }
}
