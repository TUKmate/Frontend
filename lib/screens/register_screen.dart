import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // AuthController 인스턴스 가져오기
  final _authController = Get.find<AuthController>();
  
  // 입력 컨트롤러 생성
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();  
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // 비밀번호 가리기/보이기 상태 관리
  bool _isPasswordVisible = false;

  // 회원가입 로직 함수
  Future<void> _register() async {
    // 1. 비밀번호 확인
    if (_passwordController.text != _confirmPasswordController.text) {
      Get.snackbar('오류', '비밀번호가 일치하지 않습니다.');
      return;
    }

    // 2. 컨트롤러 함수 호출
    final success = await _authController.register(
      // 이메일 필드가 디자인에 없다면 임시값이나 별도 로직 필요
      id: _idController.text.isNotEmpty ? _idController.text.trim() : "temp@example.com", 
      password: _passwordController.text,
      name: _nameController.text.trim(),     // 닉네임 필드를 이름으로 사용
      username: _usernameController.text.trim(), // 아이디
    );

    if (success) {
      Get.offAllNamed('/login'); // 성공 시 로그인 화면으로 이동
    } else {
      Get.snackbar('회원가입 실패', _authController.error.value);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _idController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // 디자인 시스템 색상 정의
    const Color primaryColor = Color(0xFF1758A8);
    const Color secondaryColor = Color(0xFF068FD3);
    const Color accentColor = Color(0xFF01B3CD);
    const Color backgroundColor = Color(0xFFF6FAFF);
    const Color textMainColor = Color(0xFF111418);
    const Color textSubColor = Color(0xFF5A6B7C);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        // 투명도 처리를 위해 withValues 사용
        backgroundColor: backgroundColor.withValues(alpha: 0.95),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: primaryColor, size: 24),
          onPressed: () => Navigator.pop(context),
          style: IconButton.styleFrom(
            backgroundColor: Colors.transparent,
            shape: const CircleBorder(),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "회원가입",
          style: TextStyle(
            color: primaryColor,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // Stack을 사용하여 하단 버튼을 화면 위에 띄움 (Floating)
      body: Stack(
        children: [
          // 1. 스크롤 가능한 메인 컨텐츠
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 10, 24, 160), // 하단 버튼 공간 확보
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 상단 칩 (TUK mate)
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: accentColor.withValues(alpha: 0.2)),
                  ),
                  child: const Text(
                    "TUK mate",
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),

                // 메인 타이틀
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: textMainColor,
                      height: 1.3,
                      fontFamily: 'Noto Sans KR', // 기본 폰트 지정
                    ),
                    children: [
                      TextSpan(text: "반가워요! 👋\n"),
                      TextSpan(
                        text: "기본 정보",
                        style: TextStyle(color: secondaryColor),
                      ),
                      TextSpan(text: "를 입력해주세요."),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                
                // 서브 타이틀
                const Text(
                  "안전하고 즐거운 룸메이트 생활을 위해\n사용하실 아이디와 비밀번호를 설정해주세요.",
                  style: TextStyle(
                    fontSize: 14,
                    color: textSubColor,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 32),

                // --- 폼 필드 시작 ---
                
                // 1. 아이디 입력
                _buildLabel("아이디"),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        hintText: "아이디 입력",
                        secondaryColor: secondaryColor,
                      ),
                    ),
                    const SizedBox(width: 10),
                    // 중복 확인 버튼
                    SizedBox(
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: secondaryColor,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(color: secondaryColor.withValues(alpha: 0.2)),
                          ),
                          shadowColor: const Color(0xFF1758A8).withValues(alpha: 0.04),
                        ),
                        child: const Text(
                          "중복 확인",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 4, top: 8),
                  child: Text(
                    "영문 소문자, 숫자를 조합하여 4~12자로 입력해주세요.",
                    style: TextStyle(fontSize: 12, color: textSubColor),
                  ),
                ),

                const SizedBox(height: 24),

                // 2. 비밀번호 입력
                _buildLabel("비밀번호"),
                const SizedBox(height: 10),
                _buildTextField(
                  hintText: "영문, 숫자, 특수문자 포함 8-20자",
                  obscureText: !_isPasswordVisible,
                  secondaryColor: secondaryColor,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey[400],
                      size: 22,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // 3. 비밀번호 확인
                _buildLabel("비밀번호 확인"),
                const SizedBox(height: 10),
                _buildTextField(
                  hintText: "비밀번호 재입력",
                  obscureText: true,
                  secondaryColor: secondaryColor,
                  // 일치 시 체크 아이콘 표시 (예시)
                  suffixIcon: const Icon(Icons.check_circle, color: accentColor, size: 22),
                ),

                const SizedBox(height: 24),

                // 4. 닉네임
                _buildLabel("닉네임"),
                const SizedBox(height: 10),
                _buildTextField(
                  hintText: "다른 학우들에게 보여질 이름",
                  secondaryColor: secondaryColor,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const SizedBox(width: 8),
                    const Icon(Icons.info, size: 16, color: accentColor),
                    const SizedBox(width: 6),
                    const Text(
                      "공백 없이 한글, 영문, 숫자만 입력 가능해요.",
                      style: TextStyle(fontSize: 12, color: textSubColor),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 2. 하단 고정 버튼 (Gradient Fade 효과 포함)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    backgroundColor.withValues(alpha: 0),
                    backgroundColor.withValues(alpha: 0.95),
                    backgroundColor,
                  ],
                  stops: const [0.0, 0.3, 1.0], // 그라데이션 위치 조정
                ),
              ),
              child: SizedBox(
                height: 58,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _authController.isLoading.value ? null : _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    shadowColor: primaryColor.withValues(alpha: 0.25),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "가입완료",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 라벨 위젯 헬퍼
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color(0xFF111418),
        ),
      ),
    );
  }

  // 텍스트 필드 위젯 헬퍼
  Widget _buildTextField({
    required String hintText,
    required Color secondaryColor,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(23, 88, 168, 0.04), // shadow-card
            offset: Offset(0, 2),
            blurRadius: 8,
            spreadRadius: -2,
          ),
        ],
      ),
      child: TextField(
        obscureText: obscureText,
        style: const TextStyle(fontSize: 15, color: Color(0xFF111418)),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[300], fontSize: 15),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: secondaryColor, width: 1),
          ),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}