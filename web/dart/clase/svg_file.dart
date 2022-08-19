import 'dart:html' show Document, DomParser, Element;
import 'dart:html';
import 'dart:svg';

class SvgFile {
  //nu este folosita. Doar am invatat sa accesez un element dintr-un fisier svg dupa id
  static void svgFile() {
    HttpRequest.getString("pictures/test.svg").then((result) {
      SvgElement svgEl = SvgElement.svg(result);

      Element tspan = svgEl.querySelector('#txtAdresa') as Element;
      final Document documentul = DomParser().parseFromString(tspan.innerHtml!, 'text/html');
      //final Element paragraph = document.querySelector('p');
      var adresa = documentul.querySelector("#tspanAdresa");
      window.alert(adresa!.innerHtml);
      adresa.innerHtml = 'Este noua adresa...';

      window.alert(adresa.innerHtml);
    });
  }
}
