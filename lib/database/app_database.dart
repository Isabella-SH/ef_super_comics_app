import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase{

  final int version=1;
  final String databaseName="SuperComic.db";
  final String tableName="comics_favorites";

  Database? db;

  //funcion patra la creacion de nuetsra base de datos
  //y la tabla llamada pokemons que almacena el id
  Future<Database> openDb()async{
    db ??= await openDatabase(join(await getDatabasesPath(), databaseName),
        onCreate: (database, version){
          database.execute("create table $tableName (id text primary key, name text, gender text, intelligence text, image text)");
        }, version: version
    );
    return db as Database;
  }
}