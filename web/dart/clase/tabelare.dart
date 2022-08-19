import 'dart:html';

//Afiseaza un map intru-un tabel
class Tabelare {
  TableElement table = TableElement(); // este in plus
  TableRowElement row = TableRowElement();
  TableCellElement cell = TableCellElement();

  adauga(Map<String, dynamic> dateTabel, String numeTabel, int skipPoz) {
    //skipPoz indica nr de key care trebuie sarit. Ex skipPoz=3 sare primele trei valori ale map (Ex.IDx,User,Table)
    numeTabel = "#" + numeTabel;

    TableElement _tabel = querySelector(numeTabel) as TableElement;

    // insert table headers:
    //print (capTabel);
    List capTabel = dateTabel.keys.toList();
    List infoTabel = dateTabel.values.toList();

    _insertDataInTabel(_tabel, capTabel, skipPoz);

    _insertDataInTabel(_tabel, infoTabel, skipPoz);

    // window.alert(table.rows[1].cells[1].text); // prints 7500
  }

  _insertDataInTabel(TableElement tabel, List datele, int skipPoz) {
    row = tabel.insertRow(-1); //insereaza cap tabel

    for (int i = datele.length - 1; i >= skipPoz; i--) {
      cell = row.insertCell(0);

      cell.text = datele[i].toString();
    }
  }
}
