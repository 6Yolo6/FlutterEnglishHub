class WordBookCategory {
  final int id;
  final String name;

  WordBookCategory({required this.id, required this.name});

  @override
  String toString() {
    return 'WordBookCategory{id: $id, name: $name}';
  }

  factory WordBookCategory.fromJson(Map<String, dynamic> json) {
    return WordBookCategory(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}