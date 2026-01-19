import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tukmate_flutter/models/post.dart';

import '../controllers/post_controller.dart';
import 'compose_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class MyPostsScreen extends StatelessWidget {
  MyPostsScreen({super.key});

  final PostController postController = Get.find<PostController>();

  // 색상 상수
  static const Color primaryColor = Color(0xFF1758A8);
  static const Color secondaryColor = Color(0xFF068FD3);
  static const Color accentColor = Color(0xFF01B3CD);
  static const Color backgroundColor = Color(0xFFF6FAFF);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color textMainColor = Color(0xFF111418);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          _buildPostList(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  /* ---------------- AppBar ---------------- */
  SliverAppBar _buildAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      backgroundColor: surfaceColor.withValues(alpha: 0.95),
      elevation: 0,
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
    );
  }

  /* ---------------- Post List ---------------- */
  Widget _buildPostList() {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
      sliver: Obx(() {
        final posts = postController.myPosts;

        if (posts.isEmpty) {
          return const SliverFillRemaining(
            child: Center(child: Text('작성한 글이 없습니다')),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return _buildPostCard(posts[index]);
            },
            childCount: posts.length,
          ),
        );
      }),
    );
  }

  /* ---------------- Post Card ---------------- */
  Widget _buildPostCard(Post post) {
    final bool isCompleted = !post.isRecruiting;

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
          _buildHeader(post, isCompleted),
          const SizedBox(height: 12),
          _buildContent(post, isCompleted),
          const SizedBox(height: 16),
          _buildActions(post),
        ],
      ),
    );
  }

  Widget _buildHeader(Post post, bool isCompleted) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: isCompleted
                ? Colors.grey[100]
                : accentColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            post.isRecruiting ? "모집중" : "모집완료",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isCompleted ? Colors.grey : accentColor,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          _formatDate(post.createdAt),
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildContent(Post post, bool isCompleted) {
    return Text(
      post.content,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 15,
        color: isCompleted ? Colors.grey : textMainColor,
        height: 1.4,
      ),
    );
  }

  Widget _buildActions(Post post) {
    return Row(
      children: [
        _buildActionButton(
          "수정",
          Icons.edit,
          secondaryColor,
          onTap: () => Get.toNamed('/post_edit', arguments: post.id),
        ),
        const SizedBox(width: 8),
        _buildActionButton(
          "삭제",
          Icons.delete,
          Colors.red,
          onTap: () => postController.deletePost(post.id),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    Color color, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
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
      ),
    );
  }

  /* ---------------- Bottom Nav ---------------- */
  Widget _buildBottomNavigationBar() {
    return SafeArea(
      child: BottomNavigationBar(
        currentIndex: 3,
        selectedItemColor: secondaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) Get.offAll(() => const HomeScreen());
          if (index == 1) Get.to(() => const ComposeScreen());
          if (index == 3) Get.offAll(() => const ProfileScreen());
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: "글쓰기"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "채팅"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "마이"),
        ],
      ),
    );
  }

  /* ---------------- Utils ---------------- */
  String _formatDate(DateTime date) {
    return "${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}";
  }
}
