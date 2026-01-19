import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/post_controller.dart';
import '../models/user.dart';
import '../widgets/post_card.dart';
import '../widgets/filter_chip.dart'; // 파일명이 custom_filter_chip.dart라면 수정 필요
import 'profile_screen.dart';
import 'compose_screen.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _selectedFilter = "전체";

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color secondaryColor = Color(0xFF068FD3);

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeTab(),
          const ComposeScreen(),
          const Center(child: Text("채팅 화면")),
          ProfileScreen(user: Get.find<AuthController>().user.value!),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF).withValues(alpha: 0.95),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withValues(alpha: 0.02),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
          border: Border(top: BorderSide(color: Colors.blue[50]!)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBottomNavItem(Icons.home_filled, "홈", 0, secondaryColor),
                _buildBottomNavItem(Icons.edit_square, "글쓰기", 1, secondaryColor),
                _buildBottomNavItem(Icons.chat_bubble, "채팅", 2, secondaryColor),
                _buildBottomNavItem(Icons.person, "마이페이지", 3, secondaryColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHomeTab() {
    const Color primaryColor = Color(0xFF1758A8);
    const Color secondaryColor = Color(0xFF068FD3);
    const Color backgroundColor = Color(0xFFF9FCFE);
    const Color textSubColor = Color(0xFF64748B);

    final postController = Get.find<PostController>();

    return Container(
      color: backgroundColor,
      child: SafeArea(
        child: RefreshIndicator(
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
                  minHeight: 140,
                  maxHeight: 140,
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
                        // 필터 칩
                        Flexible(
                          child: SingleChildScrollView(
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // 3. 게시글 리스트
              Obx(() {
                if (postController.isLoading.value) {
                  return const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (postController.posts.isEmpty) {
                  return const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: Text("게시물이 없습니다.")),
                  );
                }
                return SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 120),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final post = postController.posts[index];
                        return PostCard(
                          post: {
                            'id': post.id,
                            'title': post.content,
                            'content': post.content,
                            'user': post.name,
                            'time': post.createdAt,
                            'isRecruiting': post.isRecruiting,
                            'isBookmarked': post.isBookmarked,
                            'tags': post.tags,
                            'imageIndex': post.profileImage,
                            'major': post.major,
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
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, int index, Color activeColor) {
    final bool isSelected = _selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => _onItemTapped(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 26,
              color: isSelected ? activeColor : Colors.grey[400],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? activeColor : Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomChip(String label, Color primaryColor) {
    return CustomFilterChip(
      label: label,
      isSelected: _selectedFilter == label,
      primaryColor: primaryColor,
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
    );
  }
}

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
