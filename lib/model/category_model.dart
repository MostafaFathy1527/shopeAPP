class CategoryModel {
  final String name;
  final String image;

  CategoryModel({required this.name, required this.image});

  CategoryModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        image = json['image'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'image': image,
  };
}