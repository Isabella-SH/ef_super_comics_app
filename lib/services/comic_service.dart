import 'package:ef_super_comics_app/models/comic.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';                               //importar .io
import 'package:http/http.dart' as http;

class ComicService{

  //https://www.superheroapi.com/api.php/655562666770452/search/aqualad

  final String _baseUrl="https://www.superheroapi.com/api/";
  final String _api_token="655562666770452";

  //devuelve en algun momento una lista
  //devuelve segun un atributo, este se concatena con la _baseurl
  Future<List<Comic>?> getByName(String name) async{

    http.Response response=await http.get(Uri.parse("$_baseUrl$_api_token/search/$name"));

    //si la respuesta devuelve algo
    if(response.statusCode==HttpStatus.ok){

      //es la respuesta de tod el json
      final jsonResponse=json.decode(response.body);

      //importar el developer, para ver que devuelve el servicio al ejecutar(solo para probar)
      log(response.body);

      final List maps=jsonResponse["results"]; //'results' es donde esta el arreglo de objetos

      //cada map es asignado a un objeto usando su metodo de fromJson
      //crea una lista de Pokemon
      final comics = maps.map((e) => Comic.fromJson(e)).toList();

      //devuelve la lista de comics
      return comics;
    }
    return []; //devuelve la lista vacia
  }
}
