import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Components'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        children: [
          _cardBuilder(),
          Card(
            child: ListTile(
              title: Text("Pokemon"),
              trailing: Icon(Icons.arrow_right_outlined),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Li o leyens"),
              trailing: Icon(Icons.arrow_right_outlined),
            ),
          ),
        ],
        padding: const EdgeInsets.all(8),
      ),
    );
  }

  Widget _cardBuilder() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Dinosaur run',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Image(
                image: NetworkImage(
                    'https://laverdadnoticias.com/__export/1626574579733/sites/laverdad/img/2021/07/17/dinosaurio_de_google_juego_final.jpg_478486366.jpg')),
            TextButton(
              onPressed: () {},
              child: Text(
                'Jugar',
                style: TextStyle(color: Colors.black),
              ),
              style: TextButton.styleFrom(backgroundColor: Color(0xFFF9F871)),
            )
          ],
        ),
      ),
    );
  }
}
