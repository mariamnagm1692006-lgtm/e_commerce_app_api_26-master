class CategoryModel {
  int? id;
  String? name;
  String? slug;
  String? image;

  CategoryModel(
      {this.id,
        this.name,
        this.slug,
        this.image,});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
  }
}
