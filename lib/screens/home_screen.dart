import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/post_controller.dart';
import '../widgets/post_card.dart';
import '../widgets/filter_chip.dart'; // 만약 파일명이 custom_filter_chip.dart라면 수정 필요

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 필터 선택 상태 (추가됨)
  String _selectedFilter = "전체";

  @override
  Widget build(BuildContext context) {
    // 색상 정의
    const Color primaryColor = Color(0xFF1758A8);
    const Color secondaryColor = Color(0xFF068FD3);
    const Color backgroundColor = Color(0xFFF9FCFE);
    const Color textSubColor = Color(0xFF64748B);

    // PostController 가져오기
    final postController = Get.find<PostController>();

    return Scaffold(
      backgroundColor: backgroundColor,
      body: RefreshIndicator(
        onRefresh: () => postController.loadPosts(),
        color: primaryColor,
        child: CustomScrollView(
          slivers: [
            // 1. Sticky Header
            SliverAppBar(
              pinned: true,
              floating: true,
              backgroundColor: const Color(0xFFFFFFFF).withValues(alpha: 0.8),
              elevation: 0,
              scrolledUnderElevation: 0,
              automaticallyImplyLeading: false,
              titleSpacing: 20,
              title: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.school, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "TUK mate",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Stack(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                        ),
                        child: const Icon(Icons.notifications_outlined, color: textSubColor),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // 2. Sticky Search Bar & Filter
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverSearchDelegate(
                minHeight: 120,
                maxHeight: 120,
                child: Container(
                  color: backgroundColor.withValues(alpha: 0.95),
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: [
                      // 검색창
                      Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: secondaryColor.withValues(alpha: 0.08),
                              blurRadius: 30,
                              offset: const Offset(0, 8),
                            )
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "내 룸메이트 찾기...",
                            hintStyle: TextStyle(color: Colors.blue[200], fontSize: 15),
                            prefixIcon: const Icon(Icons.search, color: secondaryColor),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.tune, color: secondaryColor, size: 20),
                              onPressed: () {},
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // 필터 칩 (CustomFilterChip 사용)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildCustomChip("전체", primaryColor),
                            const SizedBox(width: 10),
                            _buildCustomChip("TIP(1기숙사)", primaryColor),
                            const SizedBox(width: 10),
                            _buildCustomChip("2기숙사", primaryColor),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 3. 게시글 리스트 (Obx 적용)
            Obx(() {
              // 로딩 중일 때
              if (postController.isLoading.value) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              // 게시글이 없을 때
              if (postController.posts.isEmpty) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: Text("게시물이 없습니다.")),
                );
              }

              // 게시글 리스트 표시
              return SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final post = postController.posts[index];
                      
                      return PostCard(
                        post: {
                          'id': post.id,
                          'title': post.content, // 제목이 없다면 내용 사용
                          'content': post.content,
                          'user': post.name,
                          'time': "방금 전", // 시간 변환 로직 필요 (예: post.createdAt)
                          // 아래 필드들은 Post 모델에 해당 속성이 있어야 함 (없으면 기본값)
                          'isRecruiting': true, 
                          'isNew': false,
                          'isBookmarked': post.isBookmarked,
                          'isVerified': true,
                          'tags': ["#태그"], // post.tags ?? []
                          'imageIndex': (index % 10) + 1, // 더미 이미지용
                          'major': "컴퓨터공학", // post.major
                        },
                        onBookmark: () => postController.toggleBookmark(post.id),
                        onDelete: () => postController.deletePost(post.id),
                      );
                    },
                    childCount: postController.posts.length,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  // 칩 생성 헬퍼 함수
  Widget _buildCustomChip(String label, Color primaryColor) {
    return CustomFilterChip( // [중요] widgets/filter_chip.dart의 클래스 이름
      label: label,
      isSelected: _selectedFilter == label,
      primaryColor: primaryColor,
      onTap: () {
        setState(() {
          _selectedFilter = label;
          // 필터링 로직이 필요하다면 여기에 postController.filter(label) 추가
        });
      },
    );
  }
}

// Sliver Persistent Header Delegate
class _SliverSearchDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverSearchDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverSearchDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}