
class EBookCategory {
  int id;
  String name;

  EBookCategory({required this.id, required this.name});

  @override
  String toString() {
    return 'EBookCategory{id: $id, name: $name}';
  }

  EBookCategory.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}