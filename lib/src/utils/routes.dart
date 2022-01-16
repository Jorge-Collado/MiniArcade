import 'package:flutter/material.dart';
import 'package:videojuegos/src/games/dinoGame.dart';
import 'package:videojuegos/src/games/infoDino.dart';
import 'package:videojuegos/src/games/snake.dart';
import 'package:videojuegos/src/home_page.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    'snake': (BuildContext context) => PlaySnake(),
    'home': (BuildContext context) => HomePage(),
    'infoDino': (BuildContext context) => infoDino(),
    'dinoGame': (BuildContext context) => DinoGame(),
  };
}
