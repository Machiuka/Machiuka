import 'dart:html';

class LocalStorage {
  void adauga(String cheie, String valoare) {
    //Adauga in local storage
    //Local storage nu expira. Trebuie sters cu clear() sau manual
    Storage local = window.localStorage;
    // var job1 = Job(1, "webDev", 6500, "Dart unlimited"); //am pastrat-o ca exemplu
    //window.localStorage['job'] = job1.toJson;
    try {
      local[cheie] = valoare;
    } on Exception catch (ex) {
      window.alert("Data not stored: Local storage is disabled");
    }
  }

  String? cauta(String cheie) {
    Storage local = window.localStorage;
    String? utilizator = local[cheie]; //Retrieve a data from local storage
    // local.clear(); //sterge valorile din local
    return utilizator;
  }

  void sterge() {
    Storage local = window.localStorage;
    local.clear();
  }
}

class Job {
  //neutilizata
  int? id;
  String? type;
  int? salary;
  String? company;
  Job(this.id, this.type, this.salary, this.company);
  String get toJson => '{"type":"$type","salary":"$salary","company":"$company"}';
}
