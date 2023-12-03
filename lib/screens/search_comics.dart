import 'package:ef_super_comics_app/services/comic_service.dart';
import 'package:ef_super_comics_app/widgets/comics_by_name.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchComics extends StatefulWidget {
  const SearchComics({super.key});

  @override
  State<SearchComics> createState() => _SearchComicsState();
}

class _SearchComicsState extends State<SearchComics> {

  //atributos
  List comics=[]; //puede ser vacio
  int resultCount = 0;   // contador para la cantidad de elementos

  //crear esto afuera para que no se borreo cada vez que se actualiza la vista
  final searchController=TextEditingController();

  void searchProducts(String value) async{
    //asigna a mi variable los productos si se hizo una busqueda, sino salen todos los productos
    comics= await ComicService().getByName(value)??[]; //el resultado puede ser vacio

    setState(() {
      comics=comics; //actualizo la variable
      resultCount = comics.length; //actualizo el contador
    });

    // Guarda el contador en SharedPreferences
    saveResultCount(resultCount);
  }

  // Guardo el contador en SharedPreferences
  Future<void> saveResultCount(int count) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('resultCount', count);
  }

  // Recupero el contador desde SharedPreferences
  Future<void> loadResultCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      resultCount = prefs.getInt('resultCount') ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();
    // Carga el contador al iniciar la vista
    loadResultCount();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // Crea el buscador
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          decoration: const InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
            prefixIconColor: Colors.white54,
          ),
          onSubmitted: searchProducts, // Función
        ),
        // Muestra el contador en la parte superior de la AppBar
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Chip(
              label: Text(
                'Results: $resultCount',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      // Llama a todos los productos
      body: ComicsByName(comics: comics),
    );
  }
}
