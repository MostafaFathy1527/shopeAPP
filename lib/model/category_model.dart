class CategoryModel {
  final String name;
  final String image;

  CategoryModel( this.name,  this.image);

  CategoryModel.fromJson(Map<dynamic, dynamic> json)
      : name = json['name'],
        image = json['image'];

  Map<dynamic, dynamic> toJson() => {
    'name': name,
    'image': image,
  };

}