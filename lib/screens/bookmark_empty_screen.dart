import 'package:flutter/material.dart';

class BookmarkEmptyScreen extends StatelessWidget {
  const BookmarkEmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Color definitions from Tailwind config
    const Color primaryColor = Color(0xFF1758A8);
    const Color secondaryColor = Color(0xFF068FD3);
    const Color accentColor = Color(0xFF01B3CD);
    const Color textMainColor = Color(0xFF1A202C);
    const Color textSubColor = Color(0xFF718096);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          "북마크",
          style: TextStyle(
            color: primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildEmptyState(
              primaryColor,
              secondaryColor,
              accentColor,
              textMainColor,
              textSubColor,
            ),
          ),
          _buildBottomNavigationBar(secondaryColor),
        ],
      ),
    );
  }

  Widget _buildEmptyState(
    Color primaryColor,
    Color secondaryColor,
    Color accentColor,
    Color textMainColor,
    Color textSubColor,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration Area
            SizedBox(
              width: 256,
              height: 256,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Background Gradient Blur
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          secondaryColor.withValues(alpha: 0.1),
                          accentColor.withValues(alpha: 0.05),
                        ],
                      ),
                    ),
                  ),
                  // Rotated White Container (Simulated)
                  Transform.rotate(
                    angle: 12 * 3.14159 / 180, // 12 degrees
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1758A8).withValues(alpha: 0.08),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Central Image
                  Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("https://lh3.googleusercontent.com/aida-public/AB6AXuAhAAB5ppXVCo1jvS98G-xtYng5O6jFE7T94EGhLSltSQFl3e3dbWRggmUYcMJ7KwgvbGQr8H450dXByvY_kLjf_MKhsNEmt5bUiB4nzd1PJYZRhf7h8CTlSGWApCNbI8Q4fZ_uV78wWZbnIV3m4aMUZ0OLra2HpLRK5hOOdeYZzxHBQZeKm-mXQ0y0AyQI1msCpw8N-Y0opAA4Wwu0Q9LenYbWKZsNJScciOxhVyjxorzI4nAYqrkAquXICyWd76P09K4Do58a4gdH"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  // Bouncing Square (Static for now)
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  // Pulsing Circle (Static for now)
                  Positioned(
                    bottom: 24,
                    left: 24,
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: secondaryColor.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),

            // Text Area
            Text(
              "아직 북마크한 글이 없어요",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: textMainColor,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 14),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 15,
                  color: textSubColor,
                  height: 1.6,
                  fontFamily: 'Noto Sans KR', // Assuming font is available
                ),
                children: [
                  const TextSpan(text: "마음에 드는 룸메이트를 찾아보세요!\n나중에 다시 보고 싶은 친구를 "),
                  TextSpan(
                    text: "찜",
                    style: TextStyle(
                      color: secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(text: "할 수 있어요."),
                ],
              ),
            ),
            const SizedBox(height: 48),

            // Action Button
            Container(
              constraints: const BoxConstraints(maxWidth: 260),
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to search or home
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shadowColor: primaryColor.withValues(alpha: 0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ).copyWith(
                  shadowColor: WidgetStateProperty.all(
                    primaryColor.withValues(alpha: 0.3),
                  ),
                  elevation: WidgetStateProperty.all(10), // Shadow-button equivalent
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_search, size: 20),
                    SizedBox(width: 8),
                    Text(
                      "룸메이트 찾으러 가기",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(Color secondaryColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[100]!)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_outlined, "홈", false, secondaryColor),
              _buildNavItem(Icons.forum_outlined, "게시판", false, secondaryColor),
              _buildNavItem(Icons.bookmark, "북마크", true, secondaryColor),
              _buildNavItem(Icons.person_outline, "마이페이지", false, secondaryColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    bool isActive,
    Color activeColor,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 26,
          color: isActive ? activeColor : Colors.grey[400],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            color: isActive ? activeColor : Colors.grey[400],
          ),
        ),
        if (isActive)
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: activeColor,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }
}