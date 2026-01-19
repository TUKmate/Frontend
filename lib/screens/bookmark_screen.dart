import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tukmate_flutter/widgets/bookmark_empty_modal.dart';

import '../controllers/bookmark_controller.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  String _selectedFilter = "전체";

  @override
  void initState() {
    super.initState();
    Get.find<BookmarkController>().loadBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BookmarkController>();
    final isEmpty = controller.bookmarks.isEmpty;

    const Color primaryColor = Color(0xFF1758A8);
    const Color secondaryColor = Color(0xFF068FD3);
    const Color accentColor = Color(0xFF01B3CD);
    const Color backgroundColor = Color(0xFFF6FAFF);
    const Color surfaceColor = Color(0xFFFFFFFF);
    const Color textMainColor = Color(0xFF1A202C);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: isEmpty
          ? const BookmarkEmptyScreen()
          : CustomScrollView(
              slivers: [
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
                      height: 1,
                      color: Colors.grey.withValues(alpha: 0.1),
                    ),
                  ),
                ),

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
                        ],
                      ),
                    ),
                  ),
                ),

                SliverPadding(
                  padding: const EdgeInsets.all(20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final item = controller.bookmarks[index];
                        return _buildBookmarkCard(
                          controller,
                          item,
                          surfaceColor,
                          secondaryColor,
                          accentColor,
                          textMainColor,
                        );
                      },
                      childCount: controller.bookmarks.length,
                    ),
                  ),
                ),
              ],
            ),
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
            color: isSelected ? Colors.transparent : Colors.grey[200]!,
          ),
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

  Widget _buildBookmarkCard(
    BookmarkController controller,
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
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      if (isClosed)
                        _buildTag("마감됨", Colors.grey[200]!, Colors.grey),
                      ...(item['tags'] as List<String>).map(
                        (tag) => _buildTag(
                          tag,
                          accentColor.withValues(alpha: 0.1),
                          accentColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item['title'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: isClosed ? Colors.grey : textMainColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${item['user']} · ${item['time']}",
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://i.pravatar.cc/300?img=${item['imageIndex']}",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: -6,
                  right: -6,
                  child: IconButton(
                    icon: Icon(
                      Icons.bookmark,
                      color: secondaryColor,
                    ),
                    onPressed: () {
                      controller.removeBookmark(item);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

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

class _StickyFilterDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyFilterDelegate({required this.child});

  @override
  double get minExtent => 62;

  @override
  double get maxExtent => 62;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_StickyFilterDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}
