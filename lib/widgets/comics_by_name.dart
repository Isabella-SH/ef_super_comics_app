
import 'package:ef_super_comics_app/models/comic.dart';
import 'package:ef_super_comics_app/repositories/comic_favorite_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComicsByName extends StatefulWidget {
  const ComicsByName({super.key, required this.comics});

  //parametro
  final List comics;

  @override
  State<ComicsByName> createState() => _ComicsByNameState();
}

class _ComicsByNameState extends State<ComicsByName> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.comics.length,
      itemBuilder: (context, index) {
        return ComicItem(comic: widget.comics[index]); // Recibe cada índice de la lista
      },
    );
  }
}

class ComicItem extends StatefulWidget {
  const ComicItem({super.key, required this.comic});

  //variable
  final Comic comic;

  @override
  State<ComicItem> createState() => _ComicItemState();
}

class _ComicItemState extends State<ComicItem> {

  //atributos
  bool _favorite=false;
  ComicFavoriteRepository? _comicFavoriteRepository;

  initialize()async{
    //_favorite toma el valor que da el metodo del repositorie al pasarle cada entidad
    _favorite=await _comicFavoriteRepository?.isFavorite(widget.comic)??false;
    if (mounted){ //si ya se cargo toda la informacion
      setState(() {
        _favorite=_favorite;
      });
    }
  }

  @override
  void initState(){
    _comicFavoriteRepository=ComicFavoriteRepository();
    initialize();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    //creo la imagen
    final image=Image.network(widget.comic.image!);   // '!' porque el atributo esta como '?'

    final my_con= _favorite? const Icon(
      Icons.delete,color:Colors.greenAccent,
    ):const Icon(
      Icons.favorite,color:Colors.greenAccent,
    );

    return Card(
      child: ListTile(
        leading: image,
        title: Text(widget.comic.name != null ? widget.comic.name! : 'Name is not defined'),    // '!' porque el atributo esta como '?'
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //TENER CUIDADO CON LOS ATRIBUTOS PORQUE PUEDEN SER NULOS!!!! AGREGAR VALIDACIONES
            Text('Gender: ' + (widget.comic.gender != null ? widget.comic.gender!.toString() : 'Gender is not defined')),
            Text('Intelligence: ' + (widget.comic.intelligence != null ? widget.comic.intelligence!.toString() : 'Intelligence is not defined')),
            Text('ID: ' + (widget.comic.id != null ? widget.comic.id!.toString() : 'Id is not defined')),

          ],
        ),
        trailing: IconButton(
          icon: my_con,
          //dentro del click
          onPressed: (){
            //_favorite cambia
            setState(() {
              _favorite=!_favorite;
            });
            //se agrega o elimina del repository
            //si es true lo insert, sino lo elimina
            _favorite?_comicFavoriteRepository?.insert(widget.comic):_comicFavoriteRepository?.delete(widget.comic);
          },
        ),
      ),
    );
  }
}
