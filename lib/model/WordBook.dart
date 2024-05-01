class WordBook {
  final int id;
  final String name;
  final int learnedWords;
  final int totalWords;
  final int categoryId;

  WordBook(
      this.id, this.name, this.learnedWords, this.totalWords, this.categoryId);

  factory WordBook.fromJson(Map<String, dynamic> json) {
    return WordBook(
      json['id'],
      json['name'],
      json['learnedWords'],
      json['totalWords'],
      json['categoryId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'learnedWords': learnedWords,
      'totalWords': totalWords,
      'categoryId': categoryId,
    };
  }
}
