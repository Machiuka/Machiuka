import 'dart:html';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ubf_document.dart';
import 'ubf_user.dart';
import 'ubf_client.dart';
import 'ubf_factura.dart';
import 'global.dart';

class Loader {
  //nu am nevoie de headers, fiindca setarea e din serverul php

  final _headers = {
    "Accept": "application/json",
  };

  Future<String> cautaPeServer({
    required String criteriu,
    required String tabel,
    required String numeServer,
    required String optiune,
  }) async {
    numeServer = numeServer + ".php";
    //const path = 'https://netta.ro/ubf/test/'.?numeServer.'?x={"obj":"pf"}';
    //  String path = 'http://localhost/' +
    String path = Global.url +
        numeServer +
        '?x={"criteriu":"$criteriu", "tabel":"$tabel", "optiune":"$optiune", "durataSesiunii":"${Global.durataSesiunii}", "operator":"${Global.operator}"}';

    //window.alert(path);
    // print(path);
    // var response = await http.get(Uri.parse(path), headers: _headers);
    var response = await http.get(Uri.parse(path));
    if (response.statusCode == 200) {
      String rezultat = response.body;
      //window.alert(rezultat);
//      print(rezultat);
      return rezultat;
    }
    // The GET request failed. Handle the error.
    else {
      window.alert("Couldn't open $path");
      return ("Couldn't open $path");
    }
  }

  Future<String> adaugaPeServer(
      {required String tabel,
      required String numeServer,
      required String opt,
      required String tipDoc,
      UBFDocument? docData,
      UBFFactura? factData,
      UBFUser? userData,
      UBFClient? clientData}) async {
    numeServer = numeServer + ".php";
    Map<String, dynamic>? _obj = {"tabel": tabel};
    _obj = null;
    // _obj = {"tabel": tabel, "docData": docData!.toJson(), "userData": userData};
    if (tipDoc == 'rt') {
      _obj = null;
      _obj = {"tabel": tabel, "docData": docData!.toJson()};
      //_obj = {"tipDoc": tipDoc, "tabel": tabel, "optiune": opt, "factData": factData!.toJson()};
    } else if (tipDoc == 'fe' || tipDoc == 'av') {
      _obj = null;
      //_obj = {"tabel": tabel, "optiune": opt, "factData": factData!.toJson()};
      _obj = {"tipDoc": tipDoc, "tabel": tabel, "optiune": opt, "factData": factData!.toJson()};
    } else if (tipDoc == 'cl') {
      _obj = null;
      _obj = {"tabel": tabel, "optiune": opt, "clientData": clientData!.toJson()};
    }

    String _js = jsonEncode(_obj);
    _js = _js.replaceAll("\\", "");
    _js = _js.replaceAll('"{', '[{');
    _js = _js.replaceAll(',"}}', ']}}');
    _js = _js.replaceAll(',",', '],'); //asta am adaugat pt adaugare reteta

    // window.alert(_js);
    //String _path = 'http://localhost/' + numeServer + '?x=' + _js;
    String _path = Global.url + numeServer + '?x=' + _js;
    //print(_path);
    //window.alert(_path);

    // var response = await http.get(Uri.parse(path), headers: _headers);
    var response = await http.get(Uri.parse(_path));
    if (response.statusCode == 200) {
      final jsonString = response.body;
      // window.alert(jsonString);
      //print(jsonString);
      return jsonString;
    }
    // The GET request failed. Handle the error.
    else {
      window.alert("Couldn't open $_path");
      return ("Couldn't open $_path");
    }
  }
}
