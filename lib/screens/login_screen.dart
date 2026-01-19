import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controller 가져오기
  final _authController = Get.find<AuthController>();

  // 입력창 컨트롤러
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();

  // 로그인 버튼 눌렀을 때
  Future<void> _login() async {
    final success = await _authController.login(
      id: _idController.text.trim(),
      password: _passwordController.text,
    );

    if (success) {
      Get.offAllNamed('/home');
    } else {
      Get.snackbar('로그인 실패', _authController.error.value);
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF1758A8);
    const Color secondaryColor = Color(0xFF068FD3);
    const Color accentColor = Color(0xFF01B3CD);
    const Color backgroundColor = Color(0xFFF6FAFF);
    const Color surfaceColor = Color(0xFFFFFFFF);
    const Color textLightColor = Color(0xFF64748B);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // 배경 그라데이션
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFF6FAFF), Color(0xFFFFFFFF)],
              ),
            ),
          ),

          // 배경 장식 1
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: secondaryColor.withValues(alpha: 0.05),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),

          // 배경 장식 2
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: accentColor.withValues(alpha: 0.05),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),

          // 메인 컨텐츠
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 로그인 카드
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(maxWidth: 360),
                        decoration: BoxDecoration(
                          color: surfaceColor.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withValues(alpha: 0.1),
                              blurRadius: 60,
                              offset: const Offset(0, 20),
                              spreadRadius: -15,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // 1. 로고 섹션 (수정됨)
                            Container(
                              width: 80, // 크기 살짝 키움 (64 -> 80)
                              height: 80,
                              margin: const EdgeInsets.only(bottom: 24),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24), // 둥근 모서리 조정
                                boxShadow: [
                                  BoxShadow(
                                    color: secondaryColor.withValues(alpha: 0.15),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Stack( // 스플래시 화면과 동일한 스타일 적용
                                alignment: Alignment.center,
                                children: [
                                  // 로고 이미지
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: Image.asset(
                                      'asset/images/logo.png',
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  
                                ],
                              ),
                            ),

                            const Text(
                              "TUK mate",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                letterSpacing: -0.5,
                                fontFamily: 'Lexend',
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "우리 학교 룸메이트 매칭 서비스",
                              style: TextStyle(
                                fontSize: 14,
                                color: textLightColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildTag("#친구찾기", accentColor),
                                const SizedBox(width: 8),
                                _buildTag("#기숙사", accentColor),
                              ],
                            ),

                            const SizedBox(height: 32),

                            // 2. 입력 폼 (controller 연결)
                            _buildInputField(
                              controller: _idController, // controller 추가
                              label: "아이디",
                              hintText: "아이디 입력",
                              icon: Icons.person_outline,
                              secondaryColor: secondaryColor,
                            ),
                            const SizedBox(height: 20),
                            _buildInputField(
                              controller: _passwordController, // controller 추가
                              label: "비밀번호",
                              hintText: "비밀번호 입력",
                              icon: Icons.lock_outline,
                              obscureText: true,
                              secondaryColor: secondaryColor,
                            ),

                            const SizedBox(height: 30),

                            // 3. 로그인 버튼
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: Obx(() => ElevatedButton( // Obx로 로딩 상태 반영
                                onPressed: _authController.isLoading.value ? null : _login,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  foregroundColor: Colors.white,
                                  elevation: 4,
                                  shadowColor: primaryColor.withValues(alpha: 0.4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: _authController.isLoading.value
                                    ? const CircularProgressIndicator(color: Colors.white)
                                    : const Text(
                                        "로그인",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              )),
                            ),

                            const SizedBox(height: 32),

                            // 4. 하단 링크
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () => Get.toNamed('/register'),
                                  child: const Text(
                                    "회원가입",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                  const Text(
                    "DESIGNED FOR TUK STUDENTS",
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF94A3B8),
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hintText,
    required IconData icon,
    required Color secondaryColor,
    required TextEditingController controller, // controller 인자 추가
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 6),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF475569),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 2),
            )
          ]),
          child: TextField(
            controller: controller, // controller 연결
            obscureText: obscureText,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              hintText: hintText,
              hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              prefixIcon: Icon(icon, color: const Color(0xFF94A3B8), size: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFFF1F5F9)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: secondaryColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}