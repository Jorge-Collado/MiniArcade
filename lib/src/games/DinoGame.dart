// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/material.dart';

class DinoGame extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<DinoGame> {
  
  // Varibles del dinosaurio
  double dinoX = -0.5;
  double dinoY = 1;
  double dinoWidth = 0.2;
  double dinoHeight = 0.4;

  // Variables del cactus
  double cactusX = 1;
  double cactusY = 1;
  double cactusWidth = 0.2;
  double cactusHeight = 0.4;

  // Varibles del salto
  double tiempo = 0;
  double height = 0;
  double gravedad = 12.6;
  double fuerzaDeSalto = 5;

  // Opciones de DinoGame
  //bool que se usa para saber si el juego ha comenzado.
  bool juegoHaComenzado = false;
  int milliseconds = 4;
  //El bool dobleSalto bloquea el doble salto y tambien evita que inicie muchos 
  //temporizadores en la aplicacion al saltar y le das de nuevo a saltar, ya que 
  //puede crashear la aplicacion
  bool dobleSalto = false;
  //bool que se usa para saber si el juego ha terminado.
  bool gameOver = false;
  int score = 0;
  int highScore = 0;
  //bool que se usa para saber si el dinosaurio ha pasado el cactus.
  bool dinoPasaCactus = false;

  // Metodo para comenzar DinoGame
  void startGame() {
    //Hace set del bool a true indicando que se inicia el juego.
    setState(() {
      juegoHaComenzado = true;
    });

    //A partir de los milliseconds que pongas, ira mirando todo lo que hay dentro.
    Timer.periodic(Duration(milliseconds: milliseconds), (timer) {
      //Mira si el dinosaurio ha tocado el cactus.
      if (detectaColision()) {
        //Si es asi, se para el juego, te dice Game Over y mira si la puntuacion 
        //que ha hecho es mayor a la mejor puntuacion que hay.
        gameOver = true;
        timer.cancel();
        setState(() {
          if (score > highScore) {
            //Si es asi, actualiza la mejor puntuacion con la puntuacion obtenida.
            highScore = score;
          }
        });
      }

      // Llamada al metodo del bucle que hace el cactus.
      loopCactus();

      // Llamada al metodo para actualizar la puntuacion.
      updateScore();

      // Hace que el cactus se vaya moviendo de derecha a izquierda todo el rato.
      setState(() {
        cactusX -= 0.01;
      });
    });
  }

  // Actualizar puntuacion.
  void updateScore() {
    //Si el cactus ya esta detras del dinosaurio y el bool de dinoPasaCactus esta en false, 
    //pone el bool a true y actualiza la puntuacion.
    if (cactusX < dinoX && dinoPasaCactus == false) {
      setState(() {
        dinoPasaCactus = true;
        ++score;
      });
    }
  }

  // Bucle del cactus.
  void loopCactus() {
    setState(() {
      //Si el cactus ya ha hecho su recorrido de derecha a izquierda y sale de la pantalla,
      //el cactus se ira de nuevo a la derecha para hacer el mismo recorrido de nuevo y pone
      //el bool dinoPasaCactus a false de nuevo.
      if (cactusX <= -1.2) {
        cactusX = 1.2;
        dinoPasaCactus = false;
      }
    });
  }

  // bool para mirar si ha habiado una colision del dinosaurio con el cactus.
  bool detectaColision() {
    //Mira si ha tocado el dinosaurio el cactus.
    if (cactusX <= dinoX + dinoWidth &&
        cactusX + cactusWidth >= dinoX &&
        dinoY >= cactusY - cactusHeight) {
      //Si ha habido colision, da true.
      return true;
    }

    //Si no hay colision, da false.
    return false;
  }

  // Salto del dinosaurio.
  void salto() {
    //Se pone el bool a true.
    dobleSalto = true;

    //A partir de los milliseconds que pongas, ira mirando todo lo que hay dentro.
    Timer.periodic(Duration(milliseconds: milliseconds), (timer) {
      //El peso del dinosaurio.
      height = -gravedad / 2 * tiempo * tiempo + fuerzaDeSalto * tiempo;

      setState(() {
        if (1 - height > 1) {
          resetJump();
          dinoY = 1;
          timer.cancel();
        } else {
          dinoY = 1 - height;
        }
      });

      //Mira el bool gameOver
      if (gameOver) {
        timer.cancel();
      }

      //Sube el tiempo.
      tiempo += 0.01;
    });
  }

  void resetJump() {
    //Pone el bool dobleSalto a false y hace reset al tiempo cuando ha tocado el suelo.
    dobleSalto = false;
    tiempo = 0;
  }

  //Metodo para volver a jugar.
  void jugarOtraVez() {
    setState(() {
      //Hace reset de todas las variables para que al comenzar de nuevo la partida este
      //todo donde y como estaba al principio.
      gameOver = false;
      juegoHaComenzado = false;
      cactusX = 1.2;
      score = 0;
      dinoY = 1;
      dobleSalto = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameOver
          ? (jugarOtraVez)
          : (juegoHaComenzado ? (dobleSalto ? null : salto) : startGame),
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Center(
                //Para superponer widgets uno encima de otro.
                child: Stack(
                  children: [
                    // Llamada a la clase TapToPlay
                    TapToPlay(
                      juegoHaComenzado: juegoHaComenzado,
                    ),

                    // Llamada a la clase GameOver
                    GameOver(
                      gameOver: gameOver,
                    ),

                    // Llamada a la clase Score
                    Score(
                      score: score,
                      highScore: highScore,
                    ),

                    // Llamada a la clase Dino
                    Dino(
                      dinoX: dinoX,
                      dinoY: dinoY - dinoHeight,
                      dinoWidth: dinoWidth,
                      dinoHeight: dinoHeight,
                    ),

                    // Llamada a la clase Cactus
                    Cactus(
                      cactusX: cactusX,
                      cactusY: cactusY - cactusHeight,
                      cactusWidth: cactusWidth,
                      cactusHeight: cactusHeight,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey[600],
                child: Center(
                  child: Text(
                    'Re fachero',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Lo que hay en los containers es lo que va a aparecer la primera vez que abras el juego,
//cuando le des tap desaparece y comienza el juego.
class TapToPlay extends StatelessWidget {
  
  final bool juegoHaComenzado;

  TapToPlay({required this.juegoHaComenzado});
  
  @override
  Widget build(BuildContext context) {
    return juegoHaComenzado
        ? Container()
        : Stack(
            children: [
              Container(
                alignment: Alignment(0, 0),
                child: Text(
                  'PULSA PARA JUGAR',
                  style: TextStyle(
                    color:  Colors.grey[500],
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                alignment: Alignment(0, -0.3),
                child: Text(
                  'D I N O S A U R  R U N',
                  style: TextStyle(
                    color:  Colors.grey[800],
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
        );
  }
  
}

//Aparece cuando se ha terminado el juego y dice que si quieres volver
//a jugar que solo le des tap, a la que le des se quita y vuelve a comenzar
//el juego.
class GameOver extends StatelessWidget {
  
  bool gameOver;

  GameOver({required this.gameOver});
  
  @override
  Widget build(BuildContext context) {
    return gameOver
        ? Stack(
          children: [
            Container(
              alignment: Alignment(0, -0.5),
              child: Text(
                'G A M E  O V E R',
                style: TextStyle(
                    color:  Colors.grey[800],
                    fontSize: 40,
                  ),
              ),
            ),
            Container(
              alignment: Alignment(0, -0.2),
              child: Text(
                'Pulsa para jugar de nuevo',
                style: TextStyle(
                    color:  Colors.grey[500],
                    fontSize: 22,
                  ),
              ),
            )
          ],
        )
        : Container();
  }
}

//Esta siempre en la parte de arriba del juego y es la puntuacion.
class Score extends StatelessWidget {
  
  final score;
  final highScore;

  Score({this.score, this.highScore});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                'SCORE',
                style: TextStyle(
                    color:  Colors.grey[400],
                    fontSize: 20,
                  ),
              ),
              Text(
                score.toString(),
                style: TextStyle(
                    color:  Colors.grey[600],
                    fontSize: 30,
                  ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'HIGHSCORE',
                style: TextStyle(
                    color:  Colors.grey[400],
                    fontSize: 20,
                  ),
              ),
              Text(
                highScore.toString(),
                style: TextStyle(
                    color:  Colors.grey[600],
                    fontSize: 30,
                  ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//Es el dinosario.
class Dino extends StatelessWidget {
  
  final double dinoX;
  final double dinoY;
  final double dinoWidth;
  final double dinoHeight;

  Dino({required this.dinoX, required this.dinoY, required this.dinoWidth, required this.dinoHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2 * dinoX + dinoWidth) / (2 - dinoWidth), (2 * dinoY + dinoHeight) / (2 - dinoHeight)),
      child: Container(
        height: MediaQuery.of(context).size.height * 2 / 3 * dinoHeight / 2,
        width: MediaQuery.of(context).size.width * dinoWidth / 2,
        child: Image.asset(
          'lib/images/dino.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

//Es el cactus.
class Cactus extends StatelessWidget {
  
  final double cactusX;
  final double cactusY;
  final double cactusWidth;
  final double cactusHeight;

  Cactus({required this.cactusX, required this.cactusY, required this.cactusWidth, required this.cactusHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2 * cactusX + cactusWidth) / (2 - cactusWidth), (2 * cactusY + cactusHeight) / (2 - cactusHeight)),
      child: Container(
        height: MediaQuery.of(context).size.height * 2 / 3 * cactusHeight / 2,
        width: MediaQuery.of(context).size.width * cactusWidth / 2,
        child: Image.asset(
          'lib/images/cactus.png',
          fit: BoxFit.fill,
        )),
    );
  }
}