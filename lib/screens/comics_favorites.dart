
import 'package:ef_super_comics_app/models/comic.dart';
import 'package:ef_super_comics_app/repositories/comic_favorite_repository.dart';
import 'package:ef_super_comics_app/widgets/comics_by_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComicsFavorites extends StatefulWidget {
  const ComicsFavorites({super.key});

  @override
  State<ComicsFavorites> createState() => _ComicsFavoritesState();
}

class _ComicsFavoritesState extends State<ComicsFavorites> {

  ComicFavoriteRepository? _comicFavoriteRepository;
  List<Comic>? _comics;

  initialize() async{ // "?? []" -> si es nulo, devuelve un arreglo vacio
    _comics=await _comicFavoriteRepository?.getAll()??[];
    setState((){
      _comics=_comics;
    });
  }

  @override
  void initState(){
    _comicFavoriteRepository=ComicFavoriteRepository();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: ListView.builder(
        itemCount: _comics?.length ?? 0,
        itemBuilder: ((context, index) {
      final comic = _comics![index];
      return ComicItem(comic: comic);
           }
         )
        )
    );
  }
}
