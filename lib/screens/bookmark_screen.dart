import 'package:flutter/material.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  // 필터 선택 상태
  String _selectedFilter = "전체";

  // 더미 데이터
  final List<Map<String, dynamic>> _bookmarks = [
    {
      "isClosed": false,
      "tags": ["#비흡연", "#A동", "#야행성"],
      "title": "A동 조용한 룸메 구합니다 (잠귀 밝아요)",
      "user": "디자인과23",
      "time": "10분 전",
      "imageIndex": 5,
    },
    {
      "isClosed": false,
      "tags": ["#아침형", "#식사메이트"],
      "title": "기숙사 밥 같이 먹을 사람 구해요! 혼밥 싫어요 ㅠ",
      "user": "컴공20",
      "time": "1시간 전",
      "imageIndex": 6,
    },
    {
      "isClosed": true, // 마감된 게시글
      "tags": ["#잠만잠", "#B동"],
      "title": "잠만 잘 분 구해요 (터치 X)",
      "user": "기계과21",
      "time": "어제",
      "imageIndex": 7,
    },
    {
      "isClosed": false,
      "tags": ["#게임좋아함", "#C동"],
      "title": "롤 같이 하실 룸메분 계신가요? 티어 상관없음",
      "user": "게임공학22",
      "time": "3시간 전",
      "imageIndex": 8,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // 색상 정의
    const Color primaryColor = Color(0xFF1758A8);
    const Color secondaryColor = Color(0xFF068FD3);
    const Color accentColor = Color(0xFF01B3CD);
    const Color backgroundColor = Color(0xFFF6FAFF);
    const Color surfaceColor = Color(0xFFFFFFFF);
    const Color textMainColor = Color(0xFF1A202C);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          // 1. 상단 앱바 (Sticky)
          SliverAppBar(
            pinned: true,
            floating: true,
            backgroundColor: surfaceColor.withValues(alpha: 0.9),
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.grey),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              "북마크",
              style: TextStyle(
                color: primaryColor,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.grey),
                onPressed: () {},
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                color: Colors.grey.withValues(alpha: 0.1),
                height: 1,
              ),
            ),
          ),

          // 2. 필터 바 (Sticky Header)
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyFilterDelegate(
              child: Container(
                color: backgroundColor.withValues(alpha: 0.95),
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _buildFilterChip("전체", secondaryColor),
                    const SizedBox(width: 10),
                    _buildFilterChip("모집중", secondaryColor),
                    const SizedBox(width: 10),
                    _buildFilterChip("마감됨", secondaryColor),
                    const SizedBox(width: 10),
                    _buildFilterChip("최신순", secondaryColor),
                  ],
                ),
              ),
            ),
          ),

          // 3. 북마크 리스트
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = _bookmarks[index];
                  return _buildBookmarkCard(
                    item,
                    surfaceColor,
                    secondaryColor,
                    accentColor,
                    textMainColor,
                  );
                },
                childCount: _bookmarks.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 필터 칩 위젯
  Widget _buildFilterChip(String label, Color activeColor) {
    final bool isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? activeColor : Colors.white,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey[200]!,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: activeColor.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  )
                ],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.white : Colors.grey[600],
          ),
        ),
      ),
    );
  }

  // 북마크 카드 위젯
  Widget _buildBookmarkCard(
    Map<String, dynamic> item,
    Color surfaceColor,
    Color secondaryColor,
    Color accentColor,
    Color textMainColor,
  ) {
    final bool isClosed = item['isClosed'] as bool;

    return Opacity(
      opacity: isClosed ? 0.8 : 1.0,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isClosed ? Colors.grey[50] : surfaceColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1158A8).withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 텍스트 정보 영역
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 태그 Row
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      if (isClosed)
                        _buildTag("마감됨", Colors.grey[200]!, Colors.grey),
                      ...(item['tags'] as List<String>).map((tag) {
                        final bool isAccent = tag == "#비흡연" || tag == "#아침형" || tag == "#게임좋아함";
                        return _buildTag(
                          tag,
                          isClosed
                              ? Colors.grey[100]!
                              : (isAccent ? accentColor.withValues(alpha: 0.1) : const Color(0xFFF0F4F8)),
                          isClosed
                              ? Colors.grey
                              : (isAccent ? accentColor : Colors.grey[600]!),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // 제목
                  Text(
                    item['title'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                      color: isClosed ? Colors.grey : textMainColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // 유저 정보 및 시간
                  Row(
                    children: [
                      Text(
                        item['user'],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isClosed ? Colors.grey : secondaryColor,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: 2,
                        height: 2,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                      ),
                      Text(
                        item['time'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // 이미지 영역
            Stack(
              clipBehavior: Clip.none,
              children: [
                // 이미지
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey[200],
                    image: DecorationImage(
                      image: NetworkImage("https://i.pravatar.cc/300?img=${item['imageIndex']}"),
                      fit: BoxFit.cover,
                      // 마감된 경우 흑백 처리
                      colorFilter: isClosed
                          ? const ColorFilter.mode(Colors.grey, BlendMode.saturation)
                          : null,
                    ),
                  ),
                ),
                // 북마크 버튼 (이미지 우측 상단에 걸치게)
                Positioned(
                  top: -6,
                  right: -6,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: isClosed ? Colors.grey[100] : surfaceColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: isClosed ? Colors.grey[200]! : Colors.grey[100]!),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 4,
                        )
                      ],
                    ),
                    child: Icon(
                      Icons.bookmark,
                      size: 20,
                      color: isClosed ? Colors.grey[400] : secondaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 태그 위젯 헬퍼
  Widget _buildTag(String text, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}

// SliverPersistentHeader를 위한 Delegate (필터바 고정용)
class _StickyFilterDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyFilterDelegate({required this.child});

  @override
  double get minExtent => 62.0; // 높이 설정
  @override
  double get maxExtent => 62.0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_StickyFilterDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}