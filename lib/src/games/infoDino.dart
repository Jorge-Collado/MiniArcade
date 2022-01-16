import 'package:flutter/material.dart';
import 'package:videojuegos/src/utils/theme_data.dart';

// ignore_for_file: file_names

class infoDino extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: tema(),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Dinosaur Run',
          ),
        ),
        body: Container(
            margin: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.grey[500],
              border: Border.all(
                color: Color.fromARGB(255, 0, 0, 0),
                width: 1,
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(4, 4),
                  blurRadius: 4,
                  ),
              ]),
            child: Text('hola'),
            padding: EdgeInsets.all(10),
            constraints: BoxConstraints(
              minWidth: 500,
              minHeight: 160,
            ),
          ),

      ),
    );
  }
  
}