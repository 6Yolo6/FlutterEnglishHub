
class NewsHotwords {
  final int id;
  final String title;
  final String url;
  final String imageUrl;
  final String description;
  final String content;
  final DateTime publishTime;
  final String sourceName;

  NewsHotwords({
    required this.id,
    required this.title,
    required this.url,
    required this.imageUrl,
    required this.description,
    required this.content,
    required this.publishTime,
    required this.sourceName,
  });

  @override
  String toString() {
    return 'NewsHotwords{id: $id, title: $title, url: $url, imageUrl: $imageUrl, description: $description, content: $content, publishTime: $publishTime, sourceName: $sourceName}';
  }

  factory NewsHotwords.fromJson(Map<String, dynamic> json) {
    return NewsHotwords(
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
      content: json['content'] as String,
      publishTime: DateTime.parse(json['publishTime']),
      sourceName: json['sourceName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'imageUrl': imageUrl,
      'description': description,
      'content': content,
      'publishTime': publishTime.toIso8601String(),
      'sourceName': sourceName
    };
  }
}