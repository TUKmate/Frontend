import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _floatController;
  late final AnimationController _fadeInController;
  late final AnimationController _bounceController;

  @override
  void initState() {
    super.initState();

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _fadeInController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();

    // 2초 후 로그인 화면으로 이동
    Future.delayed(const Duration(seconds:  2), () {
      Get.offAllNamed('/login');
    });
  }

  @override
  void dispose() {
    _floatController.dispose();
    _fadeInController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // primaryColor 변수 삭제됨 (사용되지 않음)
    const Color secondaryColor = Color(0xFF068FD3);
    const Color accentColor = Color(0xFF01B3CD);
    const Color backgroundColor = Color(0xFFF9FCFE);
    const Color slate800 = Color(0xFF1E293B);
    const Color slate500 = Color(0xFF64748B);
    const Color slate400 = Color(0xFF94A3B8);
    const Color slate300 = Color(0xFFCBD5E1);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // 우측 상단 Blob
          Positioned(
            top: -50,
            right: -50,
            child: AnimatedBuilder(
              animation: _floatController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, 15 * math.sin(_floatController.value * 2 * math.pi)),
                  child: child,
                );
              },
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [secondaryColor.withValues(alpha: 0.1), Colors.transparent],
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                  child: Container(color: Colors.transparent),
                ),
              ),
            ),
          ),

          // 좌측 하단 Blob
          Positioned(
            bottom: -50,
            left: -50,
            child: AnimatedBuilder(
              animation: _floatController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -15 * math.sin((_floatController.value + 0.5) * 2 * math.pi)),
                  child: child,
                );
              },
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [accentColor.withValues(alpha: 0.1), Colors.transparent],
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
                  child: Container(color: Colors.transparent),
                ),
              ),
            ),
          ),

          // 메인 컨텐츠
          SafeArea(
            child: Column(
              children: [
                const Spacer(),

                // 중앙 로고 및 텍스트
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.1),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: _fadeInController,
                    curve: Curves.easeOut,
                  )),
                  child: FadeTransition(
                    opacity: _fadeInController,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // 로고 아이콘 박스
                        Container(
                          width: 128,
                          height: 128,
                          margin: const EdgeInsets.only(bottom: 24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(36),
                            boxShadow: [
                              BoxShadow(
                                color: secondaryColor.withValues(alpha: 0.15),
                                blurRadius: 40,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(28),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [backgroundColor, Colors.white],
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'asset/images/logo.png',
                                  width: 56,
                                  height: 56,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 24,
                                right: 28,
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: accentColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 2),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.05),
                                        blurRadius: 2,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // 타이틀
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: slate800,
                              fontFamily: 'Lexend',
                              letterSpacing: -1.0,
                            ),
                            children: [
                              TextSpan(text: "TUK "),
                              TextSpan(
                                text: "mate",
                                style: TextStyle(color: secondaryColor),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 24),

                        // 태그
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: accentColor.withValues(alpha: 0.2)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.02),
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                              )
                            ],
                          ),
                          child: const Text(
                            "✨ 캠퍼스 라이프의 시작",
                            style: TextStyle(
                              color: accentColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          "한국공학대학교 기숙사\n룸메이트 매칭 서비스",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: slate500,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                // 하단 로딩 및 정보 섹션
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Column(
                    children: [
                      // Bouncing Dots Animation
                      AnimatedBuilder(
                        animation: _bounceController,
                        builder: (context, child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildDot(secondaryColor, 0),
                              const SizedBox(width: 8),
                              _buildDot(accentColor, 0.2),
                              const SizedBox(width: 8),
                              _buildDot(secondaryColor.withValues(alpha: 0.4), 0.4),
                            ],
                          );
                        },
                      ),
                      
                      const SizedBox(height: 20),
                      
                      const Text(
                        "DESIGNED FOR TUK STUDENTS",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: slate400,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Ver 2.0.1",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          color: slate300,
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
    );
  }

  Widget _buildDot(Color color, double delay) {
    final double value = math.sin((_bounceController.value * 2 * math.pi) - (delay * math.pi));
    final double offset = value > 0 ? -4.0 * value : 0;

    return Transform.translate(
      offset: Offset(0, offset),
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}