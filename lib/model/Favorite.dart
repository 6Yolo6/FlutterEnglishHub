class Favorite {
  final int userId;
  final int resourceId;
  final String resourceType;

  Favorite({
    required this.userId,
    required this.resourceId,
    required this.resourceType,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'resourceId': resourceId,
        'resourceType': resourceType,
      };

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      userId: json['userId'],
      resourceId: json['resourceId'],
      resourceType: json['resourceType'],
    );
  }
}
