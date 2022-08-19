import 'dart:html';

import 'dart/clase/login.dart';
import 'dart/clase/local_storage.dart';
import 'dart/clase/css.dart';

void main() async {
  CSS.aplicaCSS("css/styles.css");
  CSS.aplicaCSS("css/styles_button.css");
  CSS.aplicaCSS("css/styles_formular.css");
  LocalStorage local = LocalStorage();
  Login login = Login();

  String utilizator = local.cauta('utilizator').toString();

  if (utilizator.length < 5) {
    login.incarcaUser();
  } else {
    login.verificaParola();
  }
}
