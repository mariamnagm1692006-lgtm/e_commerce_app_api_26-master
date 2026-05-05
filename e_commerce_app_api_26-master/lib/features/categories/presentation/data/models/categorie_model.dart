class CategorieModel {
  int? id;
  String? name;
  String? slug;
  String? image;

  CategorieModel(
      {this.id,
        this.name,
        this.slug,
        this.image,
       });

  CategorieModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];

  }


}