import 'package:flutter/material.dart';
import 'package:videojuegos/src/games/snake.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Mini arcade'),
          backgroundColor: Theme.of(context).primaryColor,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text(
                              'Aplicación desarrollada por  \nJorge Collado, Alexis Estela y \nDavid Ballester'),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Okay'))
                          ],
                        );
                      });
                },
                icon: Icon(Icons.info))
          ]),
      body: PageView(
        controller: _controller,
        children: [
          _firstPage(context),
          _secondPage(context),
          _thirdPage(context)
        ],
      ),
    );
  }

  Widget _firstPage(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(
              'https://www.wallpaperkiss.com/wimg/b/115-1157800_big.jpg'),
          fit: BoxFit.cover,
        )),
        alignment: Alignment.center,
        child: Container(
          height: 370,
          width: 275,
          child: Column(
            children: [
              Card(
                  child: Column(
                children: [
                  Image(
                      image: NetworkImage(
                          "https://img.poki.com/cdn-cgi/image/quality=78,width=600,height=600,fit=cover,g=0.5x0.5,f=auto/9afd3b92ab41ffca7f368a8fcbd6d39a75894efe0edbc14cf1f067cf625e6678.png")),
                  Text(
                    'Dinosaur run',
                    style: TextStyle(fontSize: 22),
                  )
                ],
              )),
              SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () => {Navigator.pushNamed(context, 'dinoGame')},
                    child: Text('Jugar'),
                    style: ButtonStyle(),
                  ))
            ],
          ),
        ));
  }

  Widget _secondPage(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(
              'https://www.wallpaperkiss.com/wimg/b/115-1157800_big.jpg'),
          fit: BoxFit.cover,
        )),
        alignment: Alignment.center,
        child: Container(
          height: 370,
          width: 275,
          child: Column(
            children: [
              Card(
                  child: Column(
                children: [
                  Image(
                      image: NetworkImage(
                          "https://i.pinimg.com/originals/6e/b2/0f/6eb20f00fdee5e62e74495e88cd3223a.jpg")),
                  Text(
                    'snake',
                    style: TextStyle(fontSize: 22),
                  )
                ],
              )),
              SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () => {Navigator.pushNamed(context, 'snake')},
                    child: Text('Jugar'),
                    style: ButtonStyle(),
                  ))
            ],
          ),
        ));
  }

  Widget _thirdPage(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(
              'https://www.wallpaperkiss.com/wimg/b/115-1157800_big.jpg'),
          fit: BoxFit.cover,
        )),
        alignment: Alignment.center,
        child: Container(
          height: 370,
          width: 275,
          child: Column(
            children: [
              Card(
                  child: Column(
                children: [
                  Image(
                      image: NetworkImage(
                          "https://esports.eldesmarque.com/wp-content/uploads/2019/09/LoL-1.jpg")),
                  Text(
                    'League of legends',
                    style: TextStyle(fontSize: 22),
                  )
                ],
              )),
              SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () => {Navigator.pushNamed(context, 'snake')},
                    child: Text('Jugar'),
                    style: ButtonStyle(),
                  ))
            ],
          ),
        ));
  }
}
