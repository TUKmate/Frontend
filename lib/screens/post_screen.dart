import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/post.dart';

class PostScreen extends StatelessWidget {
  final User user;
  final Post post;

  const PostScreen({super.key, required this.user, required this.post});

  @override
  Widget build(BuildContext context) {
    // 색상 정의
    const Color primaryColor = Color(0xFF1758A8);
    const Color secondaryColor = Color(0xFF068FD3);
    const Color accentColor = Color(0xFF01B3CD);
    const Color backgroundColor = Color(0xFFF9FCFE);
    const Color surfaceColor = Color(0xFFFFFFFF);
    const Color textMainColor = Color(0xFF1E293B);
    const Color textSubColor = Color(0xFF64748B);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // 1. 전체 스크롤 가능한 컨텐츠
          SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: 120 + MediaQuery.of(context).padding.bottom, // 하단 바 높이만큼 여백
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 상단 앱바 (뒤로가기, 메뉴)
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildCircleButton(Icons.arrow_back, primaryColor, () => Navigator.pop(context)),
                        const Text(
                          "매칭 상세",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        _buildCircleButton(Icons.more_horiz, primaryColor, () {}),
                      ],
                    ),
                  ),
                ),

                // 프로필 카드 섹션
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(23, 88, 168, 0.04), // shadow-card
                        blurRadius: 20,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // 프로필 이미지
                          Stack(
                            children: [
                              Container(
                                width: 72,
                                height: 72,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  image: DecorationImage(
                                    image: NetworkImage(user.profileImage!),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(color: Colors.white, width: 3),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blue.withValues(alpha: 0.1),
                                      blurRadius: 8,
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 14,
                                      height: 14,
                                      decoration: BoxDecoration(
                                        color: Colors.green[400],
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.white, width: 2),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          // 유저 정보
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      user.nickname,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: textMainColor,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: accentColor.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(100),
                                        border: Border.all(color: accentColor.withValues(alpha: 0.2)),
                                      ),
                                      child: Text(
                                        user.dorm_type,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: accentColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "${user.major} · 작성일 ${post.createdAt}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: textSubColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // 태그들
                      Row(
                        children: [
                          _buildInfoChip(Icons.calendar_today, "01년생", secondaryColor),
                          const SizedBox(width: 8),
                          _buildInfoChip(Icons.school, "20학번", secondaryColor),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              color: accentColor,
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  color: accentColor.withValues(alpha: 0.2),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                )
                              ],
                            ),
                            child: const Text(
                              "ENFP",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 제목 섹션
                      Container(
                        margin: const EdgeInsets.only(bottom: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: accentColor.withValues(alpha: 0.2)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.02),
                                    blurRadius: 4,
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Ping Animation (Simplified)
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: accentColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "모집중",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: accentColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "저녁형 인간 룸메이트 구합니다!\n같이 롤 하실 분 환영해요 🎮",
                              style: TextStyle(
                                fontSize: 24,
                                height: 1.35,
                                fontWeight: FontWeight.bold,
                                color: textMainColor,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // 주요 생활 패턴 섹션
                      _buildSectionTitle("주요 생활 패턴", secondaryColor),
                      const SizedBox(height: 16),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 14,
                        childAspectRatio: 1.6,
                        children: [
                          _buildPatternCard(Icons.bedtime, "취침 시간", "새벽 2시 이후", secondaryColor),
                          _buildPatternCard(Icons.wb_sunny, "기상 시간", "오전 10시 이후", secondaryColor),
                          _buildPatternCard(Icons.smoke_free, "흡연 여부", "비흡연", secondaryColor),
                          _buildPatternCard(Icons.shower, "샤워 스타일", "밤에 하는 편", secondaryColor),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // 상세 조건 섹션
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: surfaceColor,
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(6, 143, 211, 0.08), // shadow-soft
                              blurRadius: 40,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle("상세 조건", accentColor),
                            const SizedBox(height: 20),
                            _buildDetailRow(Icons.hearing_disabled, "잠귀", "어두우면 잘 안 깨요"),
                            _buildDetailRow(Icons.home, "본가 방문 주기", "매주 주말"),
                            _buildDetailRow(Icons.airline_seat_flat_angled, "잠버릇", "잠버릇 없음"),
                            _buildDetailRow(Icons.sports_esports, "게임 빈도", "매일 저녁"),
                            _buildDetailRow(Icons.cleaning_services, "청소 주기", "주 1회 대청소"),
                            _buildDetailRow(Icons.headset_mic, "디코 여부", "자주 해요"),
                            _buildDetailRow(Icons.group_add, "친구 초대", "미리 말하면 가능", isLast: true),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // 상세 소개 섹션
                      Container(
                        padding: const EdgeInsets.all(24),
                        margin: const EdgeInsets.only(bottom: 32),
                        decoration: BoxDecoration(
                          color: surfaceColor,
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(6, 143, 211, 0.08),
                              blurRadius: 40,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle("상세 소개", primaryColor),
                            const SizedBox(height: 16),
                            const Text(
                              "안녕하세요! 컴퓨터공학과 20학번입니다.\n저는 주로 밤 늦게까지 코딩 과제를 하거나 게임(롤)을 즐기는 편이라, 비슷한 생활 패턴을 가진 룸메이트를 찾고 있습니다.\n새벽 2~3시쯤 자는 편이고, 아침 수업이 없으면 여유롭게 일어납니다. 잠버릇은 거의 없고 코골이도 안 합니다.\n청소는 주말에 한 번씩 같이 했으면 좋겠고, 배달 음식은 먹고 바로 치우는 깔끔한 성격입니다.\n디코를 자주 하는 편이라 소음에 민감하지 않으신 분이면 좋겠네요. 서로 배려하며 지낼 분 연락 주세요!",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF475569), // text-slate-600
                                height: 1.8,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 2. 하단 고정 버튼 (Blur Effect)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 32 + MediaQuery.of(context).padding.bottom),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.85),
                    border: Border(top: BorderSide(color: Colors.blue[100]!.withValues(alpha: 0.5))),
                  ),
                  child: Row(
                    children: [
                      // 북마크 버튼
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Icon(Icons.bookmark_border, color: Colors.grey[400], size: 28),
                      ),
                      const SizedBox(width: 16),
                      // 채팅하기 버튼
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              elevation: 8,
                              shadowColor: primaryColor.withValues(alpha: 0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.chat_bubble_outline, size: 22),
                                SizedBox(width: 10),
                                Text(
                                  "채팅 / 연락하기",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- 위젯 헬퍼 메서드들 ---

  Widget _buildCircleButton(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: const BoxDecoration(
          color: Colors.transparent, // hover 효과는 생략
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF475569), // slate-600
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color barColor) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 20,
          decoration: BoxDecoration(
            color: barColor,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }

  Widget _buildPatternCard(IconData icon, String title, String value, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.blue[50]!),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(23, 88, 168, 0.04),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 22),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, {bool isLast = false}) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      margin: EdgeInsets.only(bottom: isLast ? 0 : 16),
      decoration: BoxDecoration(
        border: isLast ? null : Border(bottom: BorderSide(color: Colors.grey[100]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: Colors.grey[400]),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF475569),
                ),
              ),
            ],
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }
}