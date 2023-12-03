import 'package:ef_super_comics_app/database/app_database.dart';
import 'package:ef_super_comics_app/models/comic.dart';
import 'package:sqflite/sqflite.dart';

class ComicFavoriteRepository{

  //insertar un pokemon
  Future insert(Comic comic) async{
    Database db= await AppDatabase().openDb();
    //metodo de pokemon.dart
    db.insert(AppDatabase().tableName, comic.toMap());
  }

  Future delete(Comic comic) async{
    Database db= await AppDatabase().openDb();
    //metodo de pokemon.dart
    db.delete(AppDatabase().tableName,
        where: "id=?", whereArgs:[comic.id]);
  }

  //lista pokemons que se marcaron como favorito
  Future<bool> isFavorite(Comic comic) async{
    Database db= await AppDatabase().openDb();
    //metodo de pokemon.dart
    final maps=await db.query(AppDatabase().tableName,
        where: "id=?", whereArgs: [comic.id]);

    //maps esta lleno es true, por eso el "isNotEmpty"
    return maps.isNotEmpty;  //devuelve todos los que se guardaron como favoritos
  }

  Future<List<Comic>> getAll() async{

    Database db= await AppDatabase().openDb();

    //para un get solo llamar a la database y el nombre de que tabla necesito la informacion
    final maps=await db.query(AppDatabase().tableName);

    //convierto los maps, que se obtienen de la tabla, a objetos Pokemon
    //retorno una lista de ello
    return maps.map((map)=> Comic.fromMap(map)).toList();
  }







}