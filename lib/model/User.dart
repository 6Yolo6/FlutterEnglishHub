
class User {
  final int id;
  final String? etc;
  final String username;
  final String? email;
  final String? telephone;
  final String? sex;
  final String avatar;

  User({
    required this.id,
    required this.username,
    this.etc,
    this.email,
    this.telephone,
    this.sex,
    required this.avatar,
  });

  @override
  String toString() {
    return 'User{id: $id, etc: $etc, username: $username, email: $email, telephone: $telephone, sex: $sex, avatar: $avatar}';
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      etc: json['etc'],
      username: json['username'],
      email: json['email'],
      telephone: json['telephone'],
      sex: json['sex'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'etc': etc,
      'username': username,
      'email': email,
      'telephone': telephone,
      'sex': sex,
      'avatar': avatar,
    };
  }
}