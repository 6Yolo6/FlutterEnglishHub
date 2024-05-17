
class EBooks {
  final int id;
  final String title;
  final String? author;
  final String filePath;
  final String fileType;
  final int seriesId;

  EBooks(
      {required this.id,
      required this.title,
      this.author,
      required this.filePath,
      required this.fileType,
      required this.seriesId});

  @override
  String toString() {
    return 'EBooks{id: $id, title: $title, author: $author, filePath: $filePath, fileType: $fileType, seriesId: $seriesId}';
  }

  factory EBooks.fromJson(Map<String, dynamic> json) {
    return EBooks(
      id: json['id'] as int,
      title: json['title'] as String,
      author: json['author'] as String?,
      filePath: json['filePath'] as String,
      fileType: json['fileType'] as String,
      seriesId: json['seriesId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'filePath': filePath,
      'fileType': fileType,
      'seriesId': seriesId
    };
  }
}
