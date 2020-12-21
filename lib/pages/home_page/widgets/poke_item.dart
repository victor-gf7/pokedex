import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/consts/consts_app.dart';

class PokeItem extends StatelessWidget {
  final String name;
  final int index;
  final Color color;
  final String num;
  final List<String> types;

  Widget setTypes(){
    List<Widget> list = [];
    types.forEach((name) {
      list.add(
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(80, 255, 255, 255)
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(name.trim(), style: TextStyle(
                  fontFamily: 'Google',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),),
              ),
            ),
            SizedBox(
              height: 5,
            )
          ],
        )
      );
    });
    return Column(
      children: list,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  const PokeItem({Key key, this.name, this.index, this.color, this.num, this.types}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Hero(
                  tag: name + 'roatation',
                  child: Opacity(
                    child: Image.asset(ConstsApp.whitePokeball, height: 80, width: 80,),
                    opacity: 0.2,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                    child: Text(
                      name,
                      style: TextStyle(
                          fontFamily: 'Google',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: setTypes(),
                  ),
                ],
              ),

              Align(
                alignment: Alignment.bottomRight,
                child: Hero(
                  tag: name,
                  child: CachedNetworkImage(
                    alignment: Alignment.bottomRight,
                    height: 80,
                    width: 80,
                    placeholder: (context, url) => new Container(
                      color: Colors.transparent,
                    ),
                    imageUrl:
                    'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$num.png',
                  ),
                ),
              ),
            ],
          ),
        ),

        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ConstsApp.getColorType(type: types[0]).withOpacity(0.7),
                ConstsApp.getColorType(type: types[0])
              ]),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
    );
  }
}
