class Post {
  final int id;   // 게시글 고유 번호
  final int userId; // 작성자 유저 ID
  final String content; // 게시글 내용  
  final DateTime createdAt; // 작성일시

  final bool isRecruiting; // 모집 중인지 여부
  final List<String> tags; // 태그 목록
  final String major; // 전공

  final String name; // 작성자 이름
  final String username; // 작성자 사용자 이름
  final String? profileImage; // 작성자 프로필 이미지 (null 가능)

  final bool isBookmarked; // 북마크 여부

  // 생성자 : 이 클래스를 만들 때 필요한 재료들
  Post({
    required this.id,
    required this.userId,
    required this.content,
    required this.createdAt,
    required this.isRecruiting,
    required this.tags,
    required this.major,
    required this.name,
    required this.username,
    this.profileImage,
    required this.isBookmarked,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['user_id'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
      isRecruiting: json['is_recruiting'],
      tags: List<String>.from(json['tags'] ?? []),
      major: json['major'] ?? '',
      name: json['user']['name'],
      username: json['user']['username'],
      profileImage: json['user']['profile_image'],
      isBookmarked: json['is_bookmarked'] ?? false,
    );
  }

  Post copyWith({String? content, bool? isBookmarked}) {
    return Post(
      id: id,
      userId: userId,
      content: content ?? this.content,
      createdAt: createdAt,
      isRecruiting: isRecruiting,
      tags: tags,
      major: major,
      name: name,
      username: username,
      profileImage: profileImage,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }
}