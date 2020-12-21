import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/consts/consts_api.dart';
import 'package:pokedex/models/pokeapi.dart';
import 'package:pokedex/consts/consts_app.dart';
import 'package:pokedex/pages/home_page/widgets/app_bar_home.dart';
import 'package:pokedex/pages/home_page/widgets/poke_item.dart';
import 'package:pokedex/stores/pokeapi_store.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PokeApiStore _pokemonStore;

  @override
  void initState() {
    super.initState();
    _pokemonStore = GetIt.instance<PokeApiStore>();
    if (_pokemonStore.pokeAPI == null) {
      _pokemonStore.fetchPokemonList();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double statusWidth = MediaQuery.of(context).padding.top; // pegar o tamanho da status bar
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Meus Pokemons',
          ),
        ],
        currentIndex: _pokemonStore.selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _pokemonStore.onItemTapped,

      ),
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        overflow: Overflow.visible,
        children: [
          Positioned(
            top:   MediaQuery.of(context).padding.top - 240 / 2.9,
            left: screenWidth - (240 / 1.6),
            child: Opacity(
              child: Image.asset(ConstsApp.dartPokeball, height: 240, width: 240,),
              opacity: 0.1,
            ),
          ),
          Container(
            child: Column(
              children: [
                Container(
                  height: statusWidth,
                ),
                AppBarHome(),
                Expanded(
                  child: Container(
                    child: Observer(
                      name: 'HomePageList',
                      builder: (BuildContext context) {
                        return (_pokemonStore.pokeAPI != null) ?
                        AnimationLimiter(
                          child: GridView.builder(
                            physics: BouncingScrollPhysics(), //adicionar dps parent: AlwaysScrollableScrollPhysics() pra ver como q fica
                              padding: EdgeInsets.all(12),
                              addAutomaticKeepAlives: true,
                              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2
                              ),
                              itemCount: _pokemonStore.pokeAPI.pokemon.length,
                              itemBuilder: (context, index){
                                Pokemon pokemon = _pokemonStore.getPokemon(index: index);

                                return AnimationConfiguration.staggeredGrid(
                                    position: index,
                                    duration: Duration(milliseconds: 375),
                                    columnCount: 2,
                                    child: ScaleAnimation(
                                      child: GestureDetector(
                                        child: PokeItem(
                                          types: pokemon.type,
                                          index: index,
                                          name: pokemon.name,
                                          num: pokemon.num,
                                        ),
                                        onTap: (){

                                        },
                                      ),
                                    )
                                );
                              }
                          ),

                        ): Center(
                          child: CircularProgressIndicator(),
                        );
                    },
                    )
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
