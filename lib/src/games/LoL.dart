import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class League extends StatefulWidget {

  @override
  _LeagueState createState() => _LeagueState();
}

class _LeagueState extends State<League> {

  var nombre = ["Xerath", "Swain", "Karthus", "Thresh", "Nami", "Caitlyn"];
  var descripcion = [
  "Xerath es un mago Ascendido de la vieja Shurima, un ser con energía arcana retorciéndose en los quebrados fragmentos de un sarcófago mágico. Durante milenios estuvo atrapado bajo las arenas del desierto, pero el ascenso de Shurima lo liberó de su prisión ancestral. Arrastrado a la locura por el poder, ahora busca recuperar lo que cree que le pertenece y reemplazar las civilizaciones soberbias del mundo con una diseñada a su imagen y semejanza.", 
  "Jericho Swain es el visionario líder de Noxus, una nación expansionista que solo venera la fuerza. Pese a haber sido relegado y a haber perdido el brazo izquierdo en las guerras de Jonia, se hizo con el control del imperio con una despiadada determinación... y una nueva mano demoníaca. En la actualidad, Swain lidera el frente y carga contra la oscuridad que se avecina, una oscuridad que solo él puede ver en los destellos que recogen los cuervos sombríos de los cadáveres a su alrededor. En medio de una espiral de sacrificio y misterio, el mayor de los secretos es que el verdadero enemigo reside en su interior.", 
  "Karthus, heraldo del olvido, es un espíritu inmortal cuyos pavorosos cantos preceden al horror de su dantesca aparición. Los vivos temen la eternidad de la no muerte, pero Karthus solo percibe hermosura y pureza en su abrazo, una comunión perfecta entre la vida y la muerte. Cuando Karthus sale de las Islas de la Sombra, es para llevar a los vivos la dicha de la muerte como apóstol de los no vivos.", 
  "Thresh, un ser sádico y astuto, es un ambicioso y trastornado espíritu de las Islas de la Sombra. Otrora guardián de innumerables secretos arcanos, acabó sucumbiendo a un poder por encima de la vida y la muerte. Ahora sobrevive torturando a sus víctimas con prolongados e inimaginables tormentos. Su último suspiro no significa el fin de sus sufrimientos, pues Thresh siembra la agonía en sus mismas almas y las aprisiona en su nefasta linterna para torturarlas durante toda la eternidad.", 
  "Nami, una joven y testaruda vastaya marina, fue la primera de la tribu marai en abandonar las olas y aventurarse en tierra firme cuando se rompió el ancestral acuerdo de su tribu con los targonianos. A falta de otra opción, Nami se encargó de completar el ritual sagrado que garantizaría el bienestar de su pueblo. En medio del caos de esta nueva era, Nami se enfrenta a un futuro incierto con agallas y determinación, utilizando su bastón de invocadora de mareas para canalizar la fuerza de los mismos océanos.",
  "Reconocida como su mejor pacificadora, Caitlyn es también la mejor arma de Piltover para librar a la ciudad de sus elusivos elementos criminales. A menudo trabaja con Vi, y actúa como un frío y eficiente contrapunto para la naturaleza más impetuosa de su socia. A pesar de que lleva un rifle hextech único, el arma más poderosa de Caitlyn es su inteligencia superior, lo que le permite colocar trampas elaboradas para cualquier infractor de la ley lo suficientemente necio como para operar en la Ciudad del Progreso y es fan del bicho SIUUU."
  ];
  var imagen = 
  [
  "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Xerath_0.jpg", 
  "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Swain_0.jpg", 
  "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Karthus_0.jpg",
  "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Thresh_0.jpg",
  "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Nami_0.jpg",
  "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Caitlyn_0.jpg"
  ];
  var colores = [Colors.blue, Colors.red, Colors.greenAccent, Colors.green, Colors.lightGreen, Colors.purple];
  int numero = 0;

  @override
  Widget build(BuildContext context) {

    if(numero > 5){
      numero = 0;
    }
    if (numero < 0){
      numero = 5;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("League of Legends"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage("https://www.wallpaperkiss.com/wimg/b/115-1157800_big.jpg"),
          fit: BoxFit.cover)
        ),
        child: Column(
          children: [
            InteractiveViewer(child: cargarImagen(numero)),
            Card(
              color: Colors.grey[200]!.withOpacity(0.7),
              shape: RoundedRectangleBorder(
              side: BorderSide(color: colores[numero], width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
              child : ListTile(
              title : Text(nombre[numero], style: TextStyle(fontSize: 25)),
              subtitle : Text(descripcion[numero])
            )
            ),
            ElevatedButton(onPressed: (){_launchURL("https://www.leagueoflegends.com/es-es/");}, child: new Text("Jugar en ordenador!")),
            Divider(),
            ElevatedButton(onPressed: (){_launchURL("https://wildrift.leagueoflegends.com/es-es/");}, child: new Text("Jugar en el telefono!"))
          ],
        ),
      ),
      floatingActionButton: crearBotones(),
    );
  }

  Widget cargarImagen(int posi){
    return Image(
      image: NetworkImage(imagen[posi]),
      width: 500,
      height: 300,
      );
  }

  Widget crearBotones(){
    return Row(
        children: [
          SizedBox(width: 30),
          FloatingActionButton(heroTag: "boton1", child: Icon(Icons.arrow_back), onPressed: _restar),
          Expanded(child: SizedBox()),
          FloatingActionButton(heroTag: "boton2", child: Icon(Icons.arrow_forward), onPressed: _sumar)
        ],
    );
  }

  void _sumar(){
    setState(() {
      numero++;
    });
  }

  void _restar(){
    setState(() {
      numero--;
    });
  }

  _launchURL(String link) {

      return launch(link);
  }
}