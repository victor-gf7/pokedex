
import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:pokedex/consts/consts_api.dart';
import 'package:pokedex/models/pokeapi.dart';
import 'package:http/http.dart' as http;
part 'pokeapi_store.g.dart';


class PokeApiStore = _PokeApiStoreBase with _$PokeApiStore;

abstract class _PokeApiStoreBase with Store {

  @observable
  PokeAPI _pokeAPI;

  @observable
  int _selectedIndex = 0;

  @computed
  PokeAPI get pokeAPI => _pokeAPI;

  @computed
  int get selectedIndex => _selectedIndex;

  @action
  fetchPokemonList(){
    loadPokeAPI().then((value) {
      _pokeAPI = value;
    });
  }
  @action
  onItemTapped(int index) {
      _selectedIndex = index;
  }

  Pokemon getPokemon({int index}) {
    return _pokeAPI.pokemon[index];
  }


  Future<PokeAPI> loadPokeAPI() async {
    try {
      final response = await http.get(ConstsAPI.pokeApiURL);
      var decodeJson = jsonDecode(response.body);
      return PokeAPI.fromJson(decodeJson);
    } catch (error, stacktrace) {
      print("Error loading list" + stacktrace.toString());
      return null;
    }
  }
}