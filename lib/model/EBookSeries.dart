
class EBookSeries {
  int id;
  String name;
  int categoryId;

  EBookSeries({required this.id, 
  required this.name, 
  required this.categoryId});

  @override
  String toString() {
    return 'EBookSeries{id: $id, name: $name, categoryId: $categoryId}';
  }

  EBookSeries.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        categoryId = json['categoryId'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'categoryId': categoryId,
      };
}
