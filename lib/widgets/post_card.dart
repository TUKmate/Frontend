import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final Map<String, dynamic> post; // 게시글 데이터
  final VoidCallback? onBookmark;  // 북마크 버튼 클릭 시 동작
  final VoidCallback? onDelete;    // 삭제 (길게 누르기) 동작

  const PostCard({
    super.key,
    required this.post,
    this.onBookmark,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    // 디자인 색상 (필요시 전역 테마나 상수로 빼서 관리 가능)
    const Color secondaryColor = Color(0xFF068FD3);
    const Color accentColor = Color(0xFF01B3CD);
    const Color textMain = Color(0xFF1E293B);
    const Color textSub = Color(0xFF64748B);

    return GestureDetector(
      onLongPress: onDelete, // 길게 눌러서 삭제 (테스트용)
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.03),
              blurRadius: 20,
              offset: Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.transparent),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. 상단 정보 (배지, 시간, 북마크 아이콘)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // 모집중 배지
                    if (post['isRecruiting'] == true)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: secondaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Text(
                          "모집중",
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    // 신규 배지
                    else if (post['isNew'] == true)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFECFDF5),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Text(
                          "신규",
                          style: TextStyle(
                            color: Color(0xFF059669),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    
                    const SizedBox(width: 8),
                    
                    // 작성 시간
                    Text(
                      post['time'] ?? '',
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ],
                ),
                
                // 북마크 버튼
                GestureDetector(
                  onTap: onBookmark,
                  child: Icon(
                    post['isBookmarked'] == true ? Icons.bookmark : Icons.bookmark_border,
                    color: post['isBookmarked'] == true ? secondaryColor : Colors.grey[300],
                    size: 24,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // 2. 제목 및 내용
            if (post['title'] != null) ...[
              Text(
                post['title'],
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: textMain,
                ),
              ),
              const SizedBox(height: 8),
            ],
            
            Text(
              post['content'] ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                color: textSub, // 수정: 본문 색상은 textSub가 더 자연스러움 (원하면 textMain으로 변경)
                height: 1.5,
              ),
            ),

            const SizedBox(height: 16),

            // 3. 해시태그 (데이터에 tags가 있는 경우에만 표시)
            if (post['tags'] != null && (post['tags'] as List).isNotEmpty) ...[
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: (post['tags'] as List).map((tag) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: accentColor.withValues(alpha: 0.1)),
                  ),
                  child: Text(
                    tag.toString(),
                    style: const TextStyle(
                      color: accentColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )).toList(),
              ),
              const SizedBox(height: 16),
            ],

            Divider(color: Colors.grey[100], thickness: 1, height: 1),
            const SizedBox(height: 12),

            // 4. 유저 정보 (프로필, 이름, 전공, 인증마크)
            Row(
              children: [
                // 프로필 이미지
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                    image: post['imageIndex'] != null 
                      ? DecorationImage(
                          image: NetworkImage("https://i.pravatar.cc/150?img=${post['imageIndex']}"),
                          fit: BoxFit.cover,
                        )
                      : null,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4),
                    ]
                  ),
                ),
                const SizedBox(width: 12),
                
                // 유저 텍스트 정보
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          post['user'] ?? '익명',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: textMain,
                          ),
                        ),
                        const SizedBox(width: 4),
                        // 인증 마크
                        if (post['isVerified'] == true)
                          const Icon(Icons.verified, size: 14, color: accentColor)
                        else
                          Icon(Icons.verified, size: 14, color: Colors.grey[300]),
                      ],
                    ),
                    if (post['major'] != null)
                      Text(
                        post['major'],
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}