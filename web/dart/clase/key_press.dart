import 'dart:html';

class KeyPress {
  //Nu o folosesc deocamdata, doar o pastrez de exemplu.
  //Se utilizeaza astfel...
  // document.onKeyPress.listen(apasareTasta);
  apasareTasta(KeyboardEvent e) {
    if (e.keyCode == KeyCode.ENTER) {
      window.alert("Enter was pressed");
    } else {
      window.alert(e.keyCode.toString() + " was pressed"); // KeyCode este de tip integer. Spre exemplu, KeyCode=35 este # (Diez)
    }
  }
}
