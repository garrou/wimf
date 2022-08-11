class Category {
  final int id;
  final int name;
  final int image;

  Category(this.id, this.name, this.image);

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        image = json['image'];
}

List<Category> createCategories(List<dynamic>? records) => records == null
    ? List.empty()
    : records.map((json) => Category.fromJson(json)).toList(growable: false);
