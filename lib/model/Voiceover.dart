// ignore: file_names
class Voiceover {
  final int id;
  final String audioUrl;
  final int userId;
  final String username;
  final String avatar;
  final int sentenceId;
  final int likeCount;
  final DateTime createTime;

  Voiceover({
    required this.id,
    required this.audioUrl,
    required this.userId,
    required this.username,
    required this.avatar,
    required this.sentenceId,
    required this.likeCount,
    required this.createTime,
  });

  @override
  String toString() {
    return 'Voiceover{id: $id, audioUrl: $audioUrl, userId: $userId, username: $username, avatar: $avatar, sentenceId: $sentenceId, likeCount: $likeCount}, createTime: $createTime';
  }

  factory Voiceover.fromJson(Map<String, dynamic> json) {
    return Voiceover(
      id: json['id'],
      audioUrl: json['audioUrl'],
      userId: json['userId'],
      username: json['username'],
      avatar: json['avatar'],
      sentenceId: json['sentenceId'],
      likeCount: json['likeCount'],
      createTime: DateTime.parse(json['createTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'audioUrl': audioUrl,
      'userId': userId,
      'username': username,
      'avatar': avatar,
      'sentenceId': sentenceId,
      'likeCount': likeCount,
      'createTime': createTime.toIso8601String(),
    };
  }
}
