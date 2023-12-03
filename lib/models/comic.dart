
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

}
