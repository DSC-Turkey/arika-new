class CategoryModel {
  String id;
  String name;

  CategoryModel({this.id, this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  CategoryModel.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'];
}
