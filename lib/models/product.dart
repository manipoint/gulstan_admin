class ProductModel {
  static const ID = "id";
  static const NAME = "name";
  static const PICTURE = "picture";
  static const DESCRIPTION = "description";
  static const REVIEW = "review";
  static const DATE = "date";
  static const PRICE = "price";
  static const RATING = "rating";
  static const FEATURE = "feature";
  
  static const CATEGORY = "category";

  String? id;
  String? name;
  String? picture;
  String? description;
  String? review;
  String? category;
  double? price;
  double? rating;
  bool? feature;
  

  ProductModel(
      {this.id,
      this.name,
      this.picture,
      this.description,
      this.review,
      this.price,
      this.rating,
      this.feature,
      this.category});

  ProductModel.fromMap(Map<String, dynamic> data) {
    id = data[ID];
    name = data[NAME];
    picture = data[PICTURE];
    description = data[DESCRIPTION];
    review = data[REVIEW] ?? " ";
    price = data[PRICE].toDouble();
    rating = data[RATING].toDouble() ?? 0.0;
    feature = data[FEATURE];
    category =data[CATEGORY];
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "picture": picture,
        "description": description,
        "review": review,
        "price": price,
        "rating": rating,
        "feature": feature,
        "category": category
      };
}

class Picture {
  String? thumbnail;

  Picture({this.thumbnail});

  Picture.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() => {"thumbnail": thumbnail};
}
