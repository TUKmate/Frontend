class User {
  final int id;
  final String name;
  final String username;
  final String? profileImage;   // null일 수도 있어서 ? 넣음
  final DateTime createdAt;

  // 생성자
  User({
    required this.id,
    required this.name,
    required this.username,
    this.profileImage,
    required this.createdAt,
  });

  //JSON(Map) -> User 객체로 변환
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      profileImage: json['profile_image'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}