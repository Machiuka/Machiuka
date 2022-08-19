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
  final bool _debug = false; //True afiseaza mesaje de debug

  final _headers = {
    "Accept": "application/json",
  };

  Future<String> aviz2Fact(
      {required String nrAviz,
      required String dataAviz,
      required String tabel,
      required String numeServer,
      required String codDoc,
      required String dataDoc,
      required String optiune}) async {
    numeServer = numeServer + ".php";
    String query = "";

    query =
        '?x={"tipDoc":"$nrAviz", "tabel":"$tabel", "optiune":"$optiune", "codDoc":"$codDoc", "dataDoc":"$dataDoc", "dataAviz":"$dataAviz"}';

    String path = Global.url + numeServer + query;
    //window.alert(path);
    //print(path);
    if (_debug == true) {
      window.alert(path);
      print(path);
    }
    // var response = await http.get(Uri.parse(path), headers: _headers);
    var response = await http.get(Uri.parse(path));
    if (response.statusCode == 200) {
      String rezultat = response.body;
      if (_debug == true) {
        window.alert(rezultat);
        print(rezultat);
      }
      return rezultat;
    }
    // The GET request failed. Handle the error.
    else {
      window.alert("Couldn't open $path");
      return ("Couldn't open $path");
    }
  }

  Future<String> cautaPeServer(
      {required String criteriu,
      required String tabel,
      required String numeServer,
      required String optiune,
      String? dataInceput,
      String? dataSfarsit,
      String? produs}) async {
    numeServer = numeServer + ".php";
    String query = "";
    if (numeServer == "serverRaportare.php") {
      query =
          '?x={"criteriu":"$criteriu", "tabel":"$tabel", "optiune":"$optiune", "dataInceput":"${dataInceput}", "dataSfarsit":"${dataSfarsit}", "produs":"${produs}"}';
    } else {
      query =
          '?x={"criteriu":"$criteriu", "tabel":"$tabel", "optiune":"$optiune", "durataSesiunii":"${Global.durataSesiunii}", "operator":"${Global.operator}"}';
    }
    String path = Global.url + numeServer + query;
    if (_debug == true) {
      window.alert(path);
      print(path);
    }
    // var response = await http.get(Uri.parse(path), headers: _headers);
    var response = await http.get(Uri.parse(path));
    if (response.statusCode == 200) {
      String rezultat = response.body;
      if (_debug == true) {
        window.alert(rezultat);
        print(rezultat);
      }
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
      _obj = {
        "tipDoc": tipDoc,
        "tabel": tabel,
        "optiune": opt,
        "factData": factData!.toJson()
      };
    } else if (tipDoc == 'cl') {
      _obj = null;
      _obj = {
        "tabel": tabel,
        "optiune": opt,
        "clientData": clientData!.toJson()
      };
    }

    String _js = jsonEncode(_obj);
    _js = _js.replaceAll("\\", "");
    _js = _js.replaceAll('"{', '[{');
    _js = _js.replaceAll(',"}}', ']}}');
    _js = _js.replaceAll(',",', '],'); //asta am adaugat pt adaugare reteta

    // window.alert(_js);
    //String _path = 'http://localhost/' + numeServer + '?x=' + _js;
    String _path = Global.url + numeServer + '?x=' + _js;
    print(_path);
    if (_debug == true) {
      print(_path);
      window.alert(_path);
    }
    // var response = await http.get(Uri.parse(path), headers: _headers);
    var response = await http.get(Uri.parse(_path));
    if (response.statusCode == 200) {
      final jsonString = response.body;
      //window.alert(jsonString);
      // print(jsonString);
      return jsonString;
    }
    // The GET request failed. Handle the error.
    else {
      window.alert("Couldn't open $_path");
      return ("Couldn't open $_path");
    }
  }
}
