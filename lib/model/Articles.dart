
class Articles {
  final int id;
  final String title;
  final String? author;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishTime;
  final String content;
  final String sourceName;
  final int wordCount;

  Articles({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishTime,
    required this.content,
    required this.sourceName,
    required this.wordCount,
  });

  @override
  String toString() {
    return 'Articles{id: $id, title: $title, author: $author, description: $description, url: $url, urlToImage: $urlToImage, publishTime: $publishTime, content: $content, sourceName: $sourceName, wordCount: $wordCount}';
  }

  factory Articles.fromJson(Map<String, dynamic> json) {
    return Articles(
      id: json['id'],
      title: json['title'],
      author: json['author'] ?? '',
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishTime: DateTime.parse(json['publishTime']),
      content: json['content'],
      sourceName: json['sourceName'],
      wordCount: json['wordCount'],
    );
  }
}
      