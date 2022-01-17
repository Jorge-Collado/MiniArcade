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
  double tiempoDeSalto = 0;
  double height = 0;
  double gravedad = 10.2;
  double fuerzaDeSalto = 5;

  // Opciones de DinoGame
  bool juegoHaComenzado = false;
  int milliseconds = 8;
  
  //Bloquea el doble salto y tambien evita que inicie muchos 
  //temporizadores en la aplicacion, ya que puede crashear la aplicacion
  bool dobleSalto = false;
  bool gameOver = false;
  int score = 0;
  int highScore = 0;
  bool dinoPasaCactus = false;

  // this will make the map start moving, ie. barriers will start to move
  void startGame() {
    setState(() {
      juegoHaComenzado = true;
    });

    Timer.periodic(Duration(milliseconds: milliseconds), (timer) {
      // check for if dino hits cactus
      if (detectaColision()) {
        gameOver = true;
        timer.cancel();
        setState(() {
          if (score > highScore) {
            highScore = score;
          }
        });
      }

      if (score > 5) {
        milliseconds = 6;
        gravedad = 11;
      } else if (score > 10) {
        milliseconds = 4;
        gravedad = 12;
      } else if (score > 15) {
        milliseconds = 3;
        gravedad = 13;
      } else if (score > 20) {
        gravedad = 15;
      } else if (score > 30) {
        gravedad = 20;
      }

      // loop barrier to keep the map going
      loopCactus();

      // update score
      updateScore();

      setState(() {
        cactusX -= 0.01;
      });
    });
  }

  // loop barriers
  void loopCactus() {
    setState(() {
      if (cactusX <= -1.2) {
        cactusX = 1.2;
        dinoPasaCactus = false;
      }
    });
  }

  // update score
  void updateScore() {
    if (cactusX < dinoX && dinoPasaCactus == false) {
      setState(() {
        dinoPasaCactus = true;
        ++score;
      });
    }
  }

  // barrier collision detection
  bool detectaColision() {
    if (cactusX <= dinoX + dinoWidth &&
        cactusX + cactusWidth >= dinoX &&
        dinoY >= cactusY - cactusHeight) {
      return true;
    }

    return false;
  }

  // dino jump
  void salto() {
    dobleSalto = true;
    Timer.periodic(Duration(milliseconds: milliseconds), (timer) {
      height = -gravedad / 2 * tiempoDeSalto * tiempoDeSalto + fuerzaDeSalto * tiempoDeSalto;

      setState(() {
        if (1 - height > 1) {
          resetJump();
          dinoY = 1;
          timer.cancel();
        } else {
          dinoY = 1 - height;
        }
      });

      // check if dead
      if (gameOver) {
        timer.cancel();
      }

      // keep the time going
      tiempoDeSalto += 0.01;
    });
  }

  void resetJump() {
    dobleSalto = false;
    tiempoDeSalto = 0;
  }

  void jugarOtraVez() {
    setState(() {
      gameOver = false;
      juegoHaComenzado = false;
      cactusX = 1.2;
      score = 0;
      dinoY = 1;
      dobleSalto = false;
      milliseconds = 8;
      gravedad = 10.2;
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
                child: Stack(
                  children: [
                    // tap to play
                    TapToPlay(
                      juegoHaComenzado: juegoHaComenzado,
                    ),

                    // game over screen
                    GameOver(
                      gameOver: gameOver,
                    ),

                    // scores
                    Score(
                      score: score,
                      highScore: highScore,
                    ),

                    // dino
                    Dino(
                      dinoX: dinoX,
                      dinoY: dinoY - dinoHeight,
                      dinoWidth: dinoWidth,
                      dinoHeight: dinoHeight,
                    ),

                    // barrier
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