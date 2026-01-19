import 'package:flutter/material.dart';

class MyPostsScreen extends StatefulWidget {
  const MyPostsScreen({super.key});

  @override
  State<MyPostsScreen> createState() => _MyPostsScreenState();
}

class _MyPostsScreenState extends State<MyPostsScreen> {
  // Filter state
  String _selectedFilter = "전체";

  // Dummy Data for Posts
  final List<Map<String, dynamic>> _posts = [
    {
      "status": "모집중",
      "date": "2023.10.25",
      "category": "룸메이트",
      "title": "A동 조용한 룸메 구해요!",
      "content": "잠귀 밝으신 분은 죄송합니다. 제가 늦게 자는 편이라 비슷한 생활 패턴 가지신 분이면 좋겠어요. 청소는 주 1회 같이 해요.",
      "likes": 5,
      "comments": 2,
      "isCompleted": false,
    },
    {
      "status": "거래완료",
      "date": "2023.10.20",
      "category": "장터",
      "title": "컴공 전공책 팝니다",
      "content": "거의 새 책입니다. 싸게 드려요. 필기 흔적 거의 없어요.",
      "likes": 1,
      "comments": 0,
      "isCompleted": true,
    },
    {
      "status": "모집중",
      "date": "2023.10.15",
      "category": "자유게시판",
      "title": "이번 주말 서울 카풀 하실 분",
      "content": "서울 가는 길 태워드립니다. 기름값만 N빵 해요. 정왕역 출발 예정입니다.",
      "likes": 3,
      "comments": 5,
      "isCompleted": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Colors from Tailwind config
    const Color primaryColor = Color(0xFF1758A8);
    const Color secondaryColor = Color(0xFF068FD3);
    const Color accentColor = Color(0xFF01B3CD);
    const Color backgroundColor = Color(0xFFF6FAFF);
    const Color surfaceColor = Color(0xFFFFFFFF);
    const Color textMainColor = Color(0xFF111418);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          // 1. Sticky AppBar
          SliverAppBar(
            pinned: true,
            floating: true,
            backgroundColor: surfaceColor.withValues(alpha: 0.95),
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: primaryColor),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              "내가 쓴 글",
              style: TextStyle(
                color: textMainColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(color: Colors.blue[50], height: 1),
            ),
          ),

          // 2. Sticky Filter Bar
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyFilterDelegate(
              child: Container(
                color: backgroundColor,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildFilterChip("전체", secondaryColor),
                    const SizedBox(width: 8),
                    _buildFilterChip("룸메이트", secondaryColor),
                    const SizedBox(width: 8),
                    _buildFilterChip("자유게시판", secondaryColor),
                    const SizedBox(width: 8),
                    _buildFilterChip("장터", secondaryColor),
                  ],
                ),
              ),
            ),
          ),

          // 3. Post List
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 100), // Bottom padding for nav bar
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final post = _posts[index];
                  // Filter logic (simple implementation)
                  if (_selectedFilter != "전체" && post['category'] != _selectedFilter) {
                    return const SizedBox.shrink();
                  }
                  return _buildPostCard(
                    post,
                    surfaceColor,
                    secondaryColor,
                    accentColor,
                    textMainColor,
                  );
                },
                childCount: _posts.length,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(secondaryColor, surfaceColor),
    );
  }

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
            color: isSelected ? Colors.transparent : Colors.blue[100]!,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: activeColor.withValues(alpha: 0.3),
                    blurRadius: 4,
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
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Colors.grey[600],
          ),
        ),
      ),
    );
  }

  Widget _buildPostCard(
    Map<String, dynamic> post,
    Color surfaceColor,
    Color secondaryColor,
    Color accentColor,
    Color textMainColor,
  ) {
    final bool isCompleted = post['isCompleted'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue[50]!),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(6, 143, 211, 0.08),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Status, Date, Category
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? Colors.grey[100]
                          : accentColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isCompleted
                            ? Colors.grey[300]!
                            : accentColor.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Text(
                      post['status'],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isCompleted ? Colors.grey[500] : accentColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    post['date'],
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  post['category'],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Title & Content
          Text(
            post['title'],
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: isCompleted ? Colors.grey[500] : textMainColor,
              decoration: isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            post['content'],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),

          // Footer: Stats & Actions
          Container(
            padding: const EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey[50]!)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Stats
                Row(
                  children: [
                    _buildStatItem(Icons.favorite, post['likes'].toString(), secondaryColor),
                    const SizedBox(width: 16),
                    _buildStatItem(Icons.chat_bubble, post['comments'].toString(), secondaryColor),
                  ],
                ),
                // Action Buttons
                Row(
                  children: [
                    _buildActionButton("수정", Icons.edit, secondaryColor, secondaryColor.withValues(alpha: 0.05)),
                    const SizedBox(width: 8),
                    _buildActionButton("삭제", Icons.delete, Colors.red[400]!, Colors.red[50]!),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String count, Color activeColor) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[400]), // Inactive color
        const SizedBox(width: 4),
        Text(
          count,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(Color secondaryColor, Color surfaceColor) {
    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        border: Border(top: BorderSide(color: Colors.grey[100]!)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_outlined, "홈", false, secondaryColor),
              _buildNavItem(Icons.edit_square, "글쓰기", false, secondaryColor),
              _buildNavItem(Icons.chat_bubble_outline, "채팅", false, secondaryColor),
              _buildNavItem(Icons.person, "마이페이지", true, secondaryColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive, Color activeColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 24,
          color: isActive ? activeColor : Colors.grey[400],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            color: isActive ? activeColor : Colors.grey[400],
          ),
        ),
      ],
    );
  }
}

class _StickyFilterDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyFilterDelegate({required this.child});

  @override
  double get minExtent => 60.0;
  @override
  double get maxExtent => 60.0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_StickyFilterDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}