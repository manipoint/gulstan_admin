class CategoryModel {
  static const ID = "id";
  static const NAME = "name";
  static const IMAGE = "image";

  int? id;
  String? name;
  String? image;

  CategoryModel({this.id, this.name, this.image});
  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json[ID];
    name = json[NAME];
    image = json[IMAGE];
  }

  Map<String, dynamic> toJson() => {"id": this.id, "name": this.name, "image": this.image};
}
