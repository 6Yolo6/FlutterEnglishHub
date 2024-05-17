class WordBooks {
  final int id;
  final String name;
  final int categoryId;
  final int wordCount;

  WordBooks({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.wordCount,
  });

  @override
  String toString() {
    return 'WordBooks{id: $id, name: $name, categoryId: $categoryId, wordCount: $wordCount}';
  }

  factory WordBooks.fromJson(Map<String, dynamic> json) {
    return WordBooks(
      id: json['id'],
      name: json['name'],
      categoryId: json['categoryId'],
      wordCount: json['wordCount'],
    );
  }
}