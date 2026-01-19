class User {
  final int id;
  final String nickname;
  final String username;
  final String major;
  final String dorm_type;
  final String sex;
  final int age;
  final String? profileImage; // null일 수도 있어서 ? 넣음
  final DateTime createdAt;

  // 생성자
  User({
    required this.id,
    required this.nickname,
    required this.username,
    required this.major,
    required this.dorm_type,
    required this.sex,
    required this.age,
    this.profileImage,
    required this.createdAt
  });

  //JSON(Map) -> User 객체로 변환
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nickname: json['nickname'],
      username: json['username'],
      major: json['major'] ?? '',
      dorm_type: json['dorm_type'] ?? '',
      sex: json['sex'] ?? '',
      age: json['age'] ?? 0,
      profileImage: json['profile_image'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}