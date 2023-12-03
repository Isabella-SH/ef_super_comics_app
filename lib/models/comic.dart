
class Comic {
  final String? id;
  final String? name;
  final String? gender;
  final String? intelligence;
  final String? image;

  Comic(
      {this.id,
        this.name,
        this.gender,
        this.intelligence,
        this.image,
      });

  //pasar de json a objeto
  Comic.fromJson(Map<String, dynamic> json):
    id = json['id'],
    name = json['name'],
    gender = json['appearance']['gender'].toString(),  //como es anidado convertilo a string
    intelligence = json['powerstats']['intelligence'].toString(),
    image = json['image']['url'].toString();

  //retorna un mapa con los datos que se tenga en esta clase
  //para el repository
  Map<String,dynamic> toMap(){
    return {
      'id':id,
      'name':name,
      'gender': gender,
      'intelligence':intelligence,
      'image': image
    };
  }

  //convierte un map a objeto
  //sirve para que convierta lo que devuleve la tabla de nuestra base de datos creada
  //para el getAll()
  Comic.fromMap(Map<String, dynamic>map):
        id=map['id'],
        name=map["name"],
        gender=map["gender"],
        intelligence= map["intelligence"],
        image= map["image"];

}
