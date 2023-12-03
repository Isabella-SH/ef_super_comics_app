import 'package:ef_super_comics_app/services/comic_service.dart';
import 'package:ef_super_comics_app/widgets/comics_by_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchComics extends StatefulWidget {
  const SearchComics({super.key});

  @override
  State<SearchComics> createState() => _SearchComicsState();
}

class _SearchComicsState extends State<SearchComics> {

  //atributos
  List comics=[]; //puede ser vacio

  //crear esto afuera para que no se borreo cada vez que se actualiza la vista
  final searchController=TextEditingController();

  void searchProducts(String value) async{
    //asigna a mi variable los productos si se hizo una busqueda, sino salen todos los productos
    comics= await ComicService()?.getByName(value)??[]; //el resultado puede ser vacio
    setState(() {
      comics=comics; //actualizo la variable
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //CREA EL BUSCADOR
      appBar: AppBar(
        title: TextField(
            controller: searchController,
            style: const TextStyle(color: Colors.white, fontWeight:FontWeight.bold),
            decoration: const InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Colors.white54
            ),
            onSubmitted: searchProducts          //FUNCION
        ),
      ),
      //LLAMA A TODOS LOS PRODUCTOS
      body: ComicsByName(comics: comics),
    );
  }
}
