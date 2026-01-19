import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../models/user.dart';
import 'my_posts_screen.dart';
import 'profile_edit_screen.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _authController = Get.find<AuthController>();


  Widget build(BuildContext context) {
    final user = _authController.user.value;
    // ✅ 개발 단계용 더미 유저
    final displayUsername = user?.username ?? "홍길동";
    
    //if (user == null) return const SizedBox(); // 유저 정보 없으면 빈 화면

    // 색상 정의
    const Color primaryColor = Color(0xFF1758A8);
    const Color secondaryColor = Color(0xFF068FD3);
    const Color backgroundColor = Color(0xFFF6FAFF);
    const Color surfaceColor = Color(0xFFFFFFFF);
    const Color textMainColor = Color(0xFF1F293B);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // 1. 배경 헤더 (고정 위치)
          Container(
            height: 320, // 넉넉한 높이
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(23, 88, 168, 0.1),
                  blurRadius: 40,
                  offset: Offset(0, 10),
                ),
              ],
            ),
          ),

          // 2. 스크롤 가능한 전체 콘텐츠
          SingleChildScrollView(
            child: Column(
              children: [
                // 헤더 내용 (SafeArea 적용)
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
                    child: Column(
                      children: [
                        // 상단 바 (제목 + 알림)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "마이페이지",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.notifications_outlined,
                                color: Colors.white,
                              ),
                              style: IconButton.styleFrom(
                                visualDensity: VisualDensity.compact,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        // 사용자 이름 섹션
                        Column(
                          children: [
                            Text(
                              "반가워요!",
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.7),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.0,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              displayUsername,
                              //user.username,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // 메인 카드 섹션 (위로 끌어올림 효과를 위해 padding top 조정 대신 흐름대로 배치)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // 액션 버튼 그리드 (프로필 수정, 글 관리)
                      Row(
                        children: [
                          Expanded(
                            child: _buildActionCard(
                              icon: Icons.edit_square,
                              label: "프로필 수정",
                              secondaryColor: secondaryColor,
                              backgroundColor: backgroundColor,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfileEditScreen(),
                                  ),  
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildActionCard(
                              icon: Icons.history_edu,
                              label: "내가 쓴 글 관리",
                              secondaryColor: secondaryColor,
                              backgroundColor: backgroundColor,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyPostsScreen(user: widget.user),
                                  ),  
                                );
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // 기본 정보 섹션
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: surfaceColor,
                          borderRadius: BorderRadius.circular(32),
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
                            // 섹션 타이틀
                            Row(
                              children: [
                                Icon(
                                  Icons.badge_outlined,
                                  color: secondaryColor,
                                  size: 24,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  "기본 정보",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1F2937),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // 정보 그리드
                            Column(
                              children: [
                                // Row 1: 학과
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 65,
                                      child: _buildInfoBox(
                                        label: "학과",
                                      value: user?.major ?? "정보 없음",
                                        secondaryColor: secondaryColor,
                                        backgroundColor: backgroundColor,
                                        textMainColor: textMainColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),

                                // Row 2: 기숙사 (Full Width)
                                _buildInfoBox(
                                  label: "기숙사",
                                  value: user?.dorm_type ?? "정보 없음",
                                  secondaryColor: secondaryColor,
                                  backgroundColor: backgroundColor,
                                  textMainColor: textMainColor,
                                  icon: Icons.apartment,
                                ),
                                const SizedBox(height: 12),

                                // Row 3: 성별 + 나이
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildInfoBox(
                                        label: "성별",
                                        value: user?.sex ?? "정보 없음",
                                        secondaryColor: secondaryColor,
                                        backgroundColor: backgroundColor,
                                        textMainColor: textMainColor,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: _buildInfoBox(
                                        label: "나이",
                                        value: "${user?.age ?? 0}세",
                                        secondaryColor: secondaryColor,
                                        backgroundColor: backgroundColor,
                                        textMainColor: textMainColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // 로그아웃 버튼
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _authController.logout(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: surfaceColor,
                            foregroundColor: Colors.red[400],
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            shadowColor: Colors.transparent,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.logout, size: 20),
                              const SizedBox(width: 8),
                              const Text(
                                "로그아웃",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Footer Text
                      Text(
                        "TUK Mate Campus Life",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: primaryColor.withValues(alpha: 0.4),
                        ),
                      ),

                      const SizedBox(height: 40), // 하단 여백 (네비게이션 바 고려)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 상단 액션 버튼 위젯 (프로필 수정, 글 관리)
  Widget _buildActionCard({
    required IconData icon,
    required String label,
    required Color secondaryColor,
    required Color backgroundColor,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 128,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(6, 143, 211, 0.08),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: secondaryColor, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF374151), // gray-700
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 정보 박스 위젯
  Widget _buildInfoBox({
    required String label,
    required String value,
    required Color secondaryColor,
    required Color backgroundColor,
    required Color textMainColor,
    IconData? icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.transparent),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  color: textMainColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          if (icon != null)
            Icon(icon, color: secondaryColor.withValues(alpha: 0.3), size: 24),
        ],
      ),
    );
  }
}
