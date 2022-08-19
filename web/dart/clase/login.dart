import 'dart:html';
import 'dart:convert';
import 'loader.dart';
import 'load_detalii.dart';
import 'global.dart';
import 'ultim_numar.dart';

import 'local_storage.dart';

class Login {
  void incarcaUser() async {
    LocalStorage local = LocalStorage();
    Loader loader = Loader();

    LoadDetalii.incarcFormular('html/form_users.html');
    await Future.delayed(const Duration(milliseconds: 50));

    //DivElement _divButoane = querySelector('#divButoane') as DivElement;// ***** Imi da eroare pe serverul netta la compilare.****
    //Element _titluDiv = querySelector('#titluDetalii') as Element;
    late final UListElement lista = querySelector('#listaDetalii') as UListElement;
    //_divButoane.hidden = true;
    // _titluDiv.innerHtml = 'L O G I N';
    loader
        .cautaPeServer(
      criteriu: 'xxx',
      numeServer: 'serverLogare',
      optiune: 'xxx',
      tabel: 'tbl_users',
    )
        .then((rezultat) {
      final _json = json.decode(rezultat);
      lista.children.clear();
      for (int i = 0; i < _json.length; i++) {
        LIElement elem = LIElement();
        lista.children.add(elem..text = _json[i]['denumire']);
        elem.onClick.listen((e) {
          Global.codOperator = _json[i]['cod_doc'];
          Global.operator = _json[i]['denumire'];
          local.adauga('codUtilizator', Global.codOperator);
          local.adauga('utilizator', Global.operator);
          window.location.reload();
          //verificaParola();
        });
      }
    });
  }

  void verificaParola() async {
    Loader loader = Loader();
    LocalStorage local = LocalStorage();
    String userCode = '';
    userCode = local.cauta('codUtilizator').toString();
    //  window.alert("User code $userCode");
    loader.cautaPeServer(criteriu: '', tabel: 'tbl_users', numeServer: 'serverLogare', optiune: userCode).then((value) {
      // window.alert(value);
      final _json = json.decode(value);
      if (_json['userAccess'] == 'OK') {
        Global.operator = _json['userName'];
        Global.userAccess = 'OK';

        UltimNumar.ultimNumar();
      } else {
        parola();
      }
    });
  }

  void logOut() async {
    Loader loader = Loader();
    LocalStorage local = LocalStorage();
    String userCode = local.cauta('codUtilizator').toString();
    Global.durataSesiunii = 0;
    Global.userAccess = 'NotOK';
    local.sterge();
    // local.adauga('codUtilizator', 'xxx');
    //local.adauga('utilizator', 'xxx');
    loader.cautaPeServer(criteriu: '', tabel: 'tbl_users', numeServer: 'serverLogare', optiune: userCode).then((value) {
      //   window.alert(value);
      window.location.reload();
      //final _json = json.decode(value);
    });
  }

  void parola() async {
    LocalStorage local = LocalStorage();

    LoadDetalii.incarcFormular('html/form_login.html');
    await Future.delayed(const Duration(milliseconds: 50));
    FormElement _formLogin = querySelector("#formLogin") as FormElement;
    InputElement _userName = querySelector("#txtUserName") as InputElement;
    InputElement _userPass = querySelector("#txtUserPass") as InputElement;

    _userName.value = local.cauta('utilizator').toString();

    Element _btnOK = querySelector("#btnOKLogin") as Element;
    _btnOK.hidden = false;
    //_userName.onChange.listen((event) => _btnOK.hidden = false);

    _btnOK.onClick.listen((e) {
      String? pass = _userPass.value;
      String? userCode = local.cauta('codUtilizator').toString();
      _userName.value = local.cauta('utilizator').toString();
      pass = pass != null ? pass : '';
      Loader loader = Loader();

      loader.cautaPeServer(criteriu: pass, tabel: 'tbl_users', numeServer: 'serverLogare', optiune: userCode).then((value) {
        //window.alert(value);
        final _json = json.decode(value);
        if (_json['userAccess'] == 'OK') {
          Global.operator = _json['userName'];
          Global.userAccess = 'OK';
          _formLogin.remove();
          UltimNumar.ultimNumar();
        } else {
          window.alert('USER SAU PAROLA INCORECTE!!!');
          window.location.reload();
        }
      });
    });
  }
}
