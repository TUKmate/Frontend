import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  // 상태 변수
  final TextEditingController _nicknameController = TextEditingController(text: "코딩하는치타");
  final TextEditingController _ageController = TextEditingController(text: "23");
  
  String _selectedGrade = "2";
  String _selectedDorm = "tip";
  String _selectedGender = "남성"; // '남성' or '여성'
  
  bool _showToast = false;

  @override
  void initState() {
    super.initState();
    // 화면 진입 시 Toast 메시지 테스트 (실제로는 저장 버튼 누른 후 호출)
    // _showSavedToast(); 
  }

  void _showSavedToast() {
    setState(() => _showToast = true);
    Timer(const Duration(seconds: 3), () {
      if (mounted) setState(() => _showToast = false);
    });
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 색상 정의
    const Color primaryColor = Color(0xFF1758A8);
    const Color secondaryColor = Color(0xFF068FD3);
    const Color accentColor = Color(0xFF01B3CD);
    const Color backgroundColor = Color(0xFFF9FCFE);
    const Color surfaceColor = Color(0xFFFFFFFF);
    const Color inputBgColor = Color(0xFFF6FAFF);
    const Color textMainColor = Color(0xFF222831);
    const Color textSubColor = Color(0xFF64748B);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // 1. 메인 컨텐츠 (스크롤 가능)
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 80, 20, 120), // 상단 헤더, 하단 버튼 공간 확보
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 섹션 타이틀
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 20,
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "기본 정보",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // 입력 폼 카드
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(23, 88, 168, 0.05),
                        blurRadius: 40,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 닉네임 입력
                      _buildLabel("닉네임", accentColor),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: inputBgColor,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: TextField(
                          controller: _nicknameController,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textMainColor),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                            border: InputBorder.none,
                            hintText: "닉네임을 입력하세요",
                            hintStyle: const TextStyle(color: Colors.grey),
                            suffixIcon: Icon(Icons.edit, color: secondaryColor.withValues(alpha: 0.5)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const SizedBox(width: 8),
                          Icon(Icons.info_outline, size: 14, color: secondaryColor.withValues(alpha: 0.8)),
                          const SizedBox(width: 4),
                          Text(
                            "한글, 영문, 숫자 포함 2-10자",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: secondaryColor.withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 28),
                      const Divider(height: 1, color: Color(0xFFF8FAFC)), // 구분선
                      const SizedBox(height: 28),

                      // 학과 & 학년 Row
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSubLabel("학과", textSubColor),
                                const SizedBox(height: 8),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(color: Colors.grey[200]!),
                                  ),
                                  child: const Text(
                                    "컴퓨터공학과",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSubLabel("학년", textSubColor),
                                const SizedBox(height: 8),
                                _buildDropdown(
                                  value: _selectedGrade,
                                  items: const [
                                    DropdownMenuItem(value: "1", child: Text("1학년")),
                                    DropdownMenuItem(value: "2", child: Text("2학년")),
                                    DropdownMenuItem(value: "3", child: Text("3학년")),
                                    DropdownMenuItem(value: "4", child: Text("4학년")),
                                  ],
                                  onChanged: (val) => setState(() => _selectedGrade = val!),
                                  inputBgColor: inputBgColor,
                                  secondaryColor: secondaryColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 20),

                      // 기숙사 선택
                      _buildSubLabel("기숙사", textSubColor),
                      const SizedBox(height: 8),
                      _buildDropdown(
                        value: _selectedDorm,
                        items: const [
                          DropdownMenuItem(value: "tip", child: Text("TIP기숙사")),
                          DropdownMenuItem(value: "nuri", child: Text("2기숙사")),
                        ],
                        onChanged: (val) => setState(() => _selectedDorm = val!),
                        inputBgColor: inputBgColor,
                        secondaryColor: secondaryColor,
                        icon: Icons.apartment,
                      ),

                      const SizedBox(height: 28),
                      const Divider(height: 1, color: Color(0xFFF8FAFC)),
                      const SizedBox(height: 28),

                      // 성별 & 나이 Row
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSubLabel("성별", textSubColor),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: inputBgColor,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: _buildGenderButton("남성", _selectedGender == "남성", secondaryColor),
                                      ),
                                      Expanded(
                                        child: _buildGenderButton("여성", _selectedGender == "여성", secondaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSubLabel("나이", textSubColor),
                                const SizedBox(height: 8),
                                Container(
                                  decoration: BoxDecoration(
                                    color: inputBgColor,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: TextField(
                                    controller: _ageController,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textMainColor),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                      border: InputBorder.none,
                                      suffixText: "세",
                                      suffixStyle: TextStyle(color: Colors.grey, fontSize: 14),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 2. 상단 헤더 (Sticky)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.white.withValues(alpha: 0.8),
                  padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top + 8, 16, 12),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                        color: primaryColor,
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 40), // 뒤로가기 버튼 크기만큼 보정
                          child: Text(
                            "프로필 수정",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
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

          // 3. 토스트 메시지 (Animated)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 600),
            curve: Curves.fastOutSlowIn,
            top: _showToast ? 100 : -100, // 위에서 내려오거나 숨겨짐
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: accentColor.withValues(alpha: 0.25),
                      blurRadius: 35,
                      offset: const Offset(0, 12),
                    )
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.25),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check, color: Colors.white, size: 16),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      "프로필이 성공적으로 저장되었습니다",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 4. 하단 저장 버튼 (Fixed)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 16, 20, 16 + MediaQuery.of(context).padding.bottom),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.8),
                    border: Border(top: BorderSide(color: Colors.blue[50]!.withValues(alpha: 0.6))),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: () {
                        // 저장 로직 수행 후 Toast 표시
                        _showSavedToast();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentColor,
                        foregroundColor: Colors.white,
                        elevation: 4,
                        shadowColor: accentColor.withValues(alpha: 0.25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.save, size: 24),
                          SizedBox(width: 8),
                          Text(
                            "저장하기",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
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

  // --- 위젯 헬퍼 ---

  Widget _buildLabel(String text, Color dotColor) {
    return Row(
      children: [
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF068FD3), // secondary
          ),
        ),
        const SizedBox(width: 4),
        Container(
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }

  Widget _buildSubLabel(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<DropdownMenuItem<String>> items,
    required Function(String?) onChanged,
    required Color inputBgColor,
    required Color secondaryColor,
    IconData? icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: inputBgColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: Icon(icon ?? Icons.keyboard_arrow_down, color: secondaryColor),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold, // 폰트 굵게
            color: Color(0xFF068FD3), // Secondary Color
          ),
          items: items,
          onChanged: onChanged,
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Widget _buildGenderButton(String label, bool isSelected, Color activeColor) {
    return GestureDetector(
      onTap: () => setState(() => _selectedGender = label),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  )
                ]
              : null,
          border: isSelected ? Border.all(color: Colors.grey[100]!) : null,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? activeColor : Colors.grey[400],
          ),
        ),
      ),
    );
  }
}