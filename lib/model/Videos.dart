
class Videos {
  final int id;
  final String title;
  final String description;
  final String filePath;
  final String duration;
  final int category;
  final int? additionInfo;

  Videos(
      {required this.id,
      required this.title,
      required this.description,
      required this.filePath,
      required this.duration,
      required this.category,
      this.additionInfo});

  @override
  String toString() {
    return 'Videos{id: $id, title: $title, description: $description, filePath: $filePath, duration: $duration, category: $category, additionInfo: $additionInfo}';
  }

  factory Videos.fromJson(Map<String, dynamic> json) {
    return Videos(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      filePath: json['filePath'] as String,
      duration: json['duration'] as String,
      category: json['category'] as int,
      additionInfo: json['additionInfo'] as int?,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'filePath': filePath,
      'duration': duration,
      'category': category,
      'additionInfo': additionInfo
    };
  }
}