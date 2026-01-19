import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/post_controller.dart';

class ComposeScreen extends StatefulWidget {
  const ComposeScreen({super.key});

  @override
  State<ComposeScreen> createState() => _ComposeScreenState();
}

class _ComposeScreenState extends State<ComposeScreen> {
  final _controller = TextEditingController();
  final _postController = Get.find<PostController>(); 
  bool _isLoading = false;
  
  // --- 상태 변수들 ---
  String _selectedDorm = "TIP 하우스"; // 기숙사 선택
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  
  // 체크리스트 상태값
  String _mbtiIE = ""; // E, I
  String _mbtiNS = ""; // N, S
  String _mbtiFT = ""; // F, T
  String _mbtiJP = ""; // J, P
  
  String _selectedBirth = ""; // 생년
  String _selectedYear = ""; // 학번
  
  String _sleepTime = "00:00 (자정)"; // 취침 시간
  String _wakeTime = "08:00"; // 기상 시간
  
  String _smoke = ""; // 흡연 여부
  String _bug = ""; // 벌레 잡기
  String _showerStyle = ""; // 샤워 스타일
  String _showerTime = ""; // 샤워 시간
  String _sleepEar = ""; // 잠귀
  String _visit = ""; // 본가 방문
  
  // 잠버릇 (중복 선택 가능)
  bool _habitGrind = false;
  bool _habitSnore = false;
  bool _habitTalk = false;
  
  String _gameFreq = ""; // 게임 빈도
  String _cleanFreq = ""; // 청소 빈도
  String _discord = ""; // 디코 여부
  String _invite = ""; // 친구 초대

  // 게시 버튼 눌렀을떄
  Future<void> _submit() async {
    // 빈 내용 체크
    if (_controller.text.trim().isEmpty) {
    Get.snackbar('오류', '내용을 입력해주세요');
    return;
  }

  setState(() => _isLoading = true);  // 로딩 시작
  final success = await _postController.createPost(content: _controller.text);
  setState(() => _isLoading = false);

  if (success) {
     Get.back();  // 작성 완료 -> 홈으로 돌아가기
   }
 }

  @override
  void dispose() {
    _controller.dispose();  // 메모리 해제
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

    return Scaffold(
      backgroundColor: backgroundColor,
      // 1. 상단 앱바 (Sticky Header)
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "글 작성",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      
      // 2. 메인 컨텐츠 (스크롤 가능)
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 기숙사 선택 섹션
            _buildSectionTitle("기숙사 선택"),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildDormCard(
                    title: "TIP 기숙사",
                    isSelected: _selectedDorm == "TIP 기숙사",
                    onTap: () => setState(() => _selectedDorm = "TIP 기숙사"),
                    activeColor: secondaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDormCard(
                    title: "2기숙사",
                    isSelected: _selectedDorm == "2기숙사",
                    onTap: () => setState(() => _selectedDorm = "2기숙사"),
                    activeColor: secondaryColor,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // 제목 & 내용 입력 섹션
            _buildSectionTitle("제목"),
            const SizedBox(height: 6),
            TextField(
              controller: _titleController,
              decoration: _inputDecoration("룸메이트 구합니다! (한 줄 요약)"),
              style: const TextStyle(fontSize: 14),
            ),
            
            const SizedBox(height: 16),
            
            _buildSectionTitle("내용"),
            const SizedBox(height: 6),
            TextField(
              controller: _contentController,
              maxLines: 6,
              decoration: _inputDecoration("나의 생활 패턴, 바라는 점, 취미 등을 자유롭게 적어주세요."),
              style: const TextStyle(fontSize: 14, height: 1.5),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "${_contentController.text.length}/1000",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // 상세 조건 체크리스트 섹션
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(24),
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
                  // 헤더
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.checklist, color: secondaryColor, size: 20),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "상세 조건 체크리스트",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1, color: Color(0xFFF3F4F6)),
                  const SizedBox(height: 24),
                  
                  // MBTI
                  _buildSubTitle("MBTI"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildMbtiPair("E", "I", _mbtiIE, (val) => setState(() => _mbtiIE = val)),
                      _buildMbtiPair("N", "S", _mbtiNS, (val) => setState(() => _mbtiNS = val)),
                      _buildMbtiPair("F", "T", _mbtiFT, (val) => setState(() => _mbtiFT = val)),
                      _buildMbtiPair("J", "P", _mbtiJP, (val) => setState(() => _mbtiJP = val)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // 생년 (Horizontal Scroll)
                  _buildSubTitle("생년"),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: ["00", "01", "02", "03", "04", "05", "06", "07"].map((year) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: _buildChipButton(
                            label: year,
                            isSelected: _selectedBirth == year,
                            onTap: () => setState(() => _selectedBirth = year),
                            activeColor: accentColor,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // 학번 (Horizontal Scroll)
                  _buildSubTitle("학번"),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: ["18", "19", "20", "21", "22", "23", "24", "25", "26"].map((year) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: _buildChipButton(
                            label: year,
                            isSelected: _selectedYear == year,
                            onTap: () => setState(() => _selectedYear = year),
                            activeColor: accentColor,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // 시간대 선택 (Dropdown)
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSubTitle("취침 시간대"),
                            _buildDropdown(
                              value: _sleepTime,
                              items: ["22:00 이전", "23:00", "00:00 (자정)", "01:00", "02:00 이후"],
                              onChanged: (val) => setState(() => _sleepTime = val!),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSubTitle("기상 시간대"),
                            _buildDropdown(
                              value: _wakeTime,
                              items: ["07:00 이전", "08:00", "09:00", "10:00", "11:00 이후"],
                              onChanged: (val) => setState(() => _wakeTime = val!),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // 라디오 그룹들
                  _buildRadioGroup("흡연 여부", ["X (비흡연)", "O (흡연)", "많이"], _smoke, (val) => setState(() => _smoke = val), secondaryColor),
                  _buildRadioGroup("벌레 잡기", ["O (담당)", "용기", "X (도망)"], _bug, (val) => setState(() => _bug = val), secondaryColor),
                  
                  _buildSubTitle("샤워 스타일"),
                  Row(children: [
                     Expanded(child: _buildOptionButton("아침", _showerStyle == "아침", () => setState(() => _showerStyle = "아침"), secondaryColor)),
                     const SizedBox(width: 8),
                     Expanded(child: _buildOptionButton("유동", _showerStyle == "유동", () => setState(() => _showerStyle = "유동"), secondaryColor)),
                     const SizedBox(width: 8),
                     Expanded(child: _buildOptionButton("저녁", _showerStyle == "저녁", () => setState(() => _showerStyle = "저녁"), secondaryColor)),
                  ]),
                  const SizedBox(height: 24),

                  _buildRadioGroup("샤워 시간", ["10분", "30분", "60분"], _showerTime, (val) => setState(() => _showerTime = val), secondaryColor),
                  _buildRadioGroup("잠귀", ["어둡", "보통", "밝음"], _sleepEar, (val) => setState(() => _sleepEar = val), secondaryColor),
                  _buildRadioGroup("본가 방문 주기", ["자주", "가끔", "X"], _visit, (val) => setState(() => _visit = val), secondaryColor),

                  // 체크박스 그룹 (잠버릇)
                  _buildSubTitle("잠버릇 (중복 가능)"),
                  Row(
                    children: [
                      Expanded(child: _buildOptionButton("이갈이", _habitGrind, () => setState(() => _habitGrind = !_habitGrind), secondaryColor)),
                      const SizedBox(width: 8),
                      Expanded(child: _buildOptionButton("코골이", _habitSnore, () => setState(() => _habitSnore = !_habitSnore), secondaryColor)),
                      const SizedBox(width: 8),
                      Expanded(child: _buildOptionButton("잠꼬대", _habitTalk, () => setState(() => _habitTalk = !_habitTalk), secondaryColor)),
                    ],
                  ),
                  const SizedBox(height: 24),

                  _buildRadioGroup("게임 빈도", ["매일", "가끔", "X"], _gameFreq, (val) => setState(() => _gameFreq = val), secondaryColor),
                  _buildRadioGroup("청소 빈도", ["자주", "가끔", "안함"], _cleanFreq, (val) => setState(() => _cleanFreq = val), secondaryColor),
                  _buildRadioGroup("디코 여부", ["매일", "가끔", "X"], _discord, (val) => setState(() => _discord = val), secondaryColor),
                  _buildRadioGroup("친구 초대", ["좋지", "상의", "싫어"], _invite, (val) => setState(() => _invite = val), secondaryColor),
                ],
              ),
            ),
            const SizedBox(height: 100), // 하단 여백
          ],
        ),
      ),
      
      // 3. 하단 등록 버튼 (Floating Bottom Bar)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
        decoration: BoxDecoration(
          color: surfaceColor.withValues(alpha: 0.9),
          border: Border(top: BorderSide(color: Colors.grey[100]!)),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: accentColor,
              foregroundColor: Colors.white,
              elevation: 4,
              shadowColor: accentColor.withValues(alpha: 0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "등록하기",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Icon(Icons.send, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- 위젯 헬퍼 메서드들 ---

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color(0xFF6B7280), // subtext color
        ),
      ),
    );
  }

  Widget _buildSubTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color(0xFF374151), // gray-700
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFFD1D5DB)), // gray-300
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[200]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[200]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF068FD3)), // secondary
      ),
    );
  }

  // 기숙사 선택 카드
  Widget _buildDormCard({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
    required Color activeColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[50] : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? activeColor : Colors.transparent,
            width: 2,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              blurRadius: 12,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? activeColor : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
            if (isSelected)
              Positioned(
                top: 0,
                right: 0,
                child: Icon(Icons.check_circle, color: activeColor, size: 20),
              ),
          ],
        ),
      ),
    );
  }

  // MBTI 선택 쌍 (E/I, N/S 등)
  Widget _buildMbtiPair(String opt1, String opt2, String currentVal, Function(String) onSelect) {
    return Column(
      children: [
        _buildMbtiButton(opt1, currentVal == opt1, () => onSelect(opt1)),
        const SizedBox(height: 4),
        _buildMbtiButton(opt2, currentVal == opt2, () => onSelect(opt2)),
      ],
    );
  }

  Widget _buildMbtiButton(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.grey[50], // 선택시 색상 반전 주의 (HTML CSS 따름)
          // CSS: checked -> bg-accent text-white
          // 수정: HTML CSS에 맞게 색상 적용
          gradient: isSelected ? const LinearGradient(colors: [Color(0xFF01B3CD), Color(0xFF01B3CD)]) : null,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isSelected ? const Color(0xFF01B3CD) : Colors.grey[200]!),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.grey[400],
          ),
        ),
      ),
    );
  }

  // 칩 형태 버튼 (생년, 학번)
  Widget _buildChipButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required Color activeColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? activeColor : Colors.grey[50],
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: isSelected ? activeColor : Colors.grey[200]!),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? Colors.white : Colors.grey[500],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
  
  // 드롭다운 메뉴
  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          style: const TextStyle(fontSize: 12, color: Colors.black87),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  // 라디오 버튼 그룹 (3개짜리)
  Widget _buildRadioGroup(String title, List<String> options, String currentVal, Function(String) onSelect, Color activeColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSubTitle(title),
        Row(
          children: options.map((opt) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _buildOptionButton(
                  opt,
                  currentVal == opt,
                  () => onSelect(opt),
                  activeColor,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  // 공통 옵션 버튼 (라디오/체크박스 스타일)
  Widget _buildOptionButton(String label, bool isSelected, VoidCallback onTap, Color activeColor) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? activeColor : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? activeColor : Colors.grey[200]!),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isSelected ? Colors.white : Colors.grey[500],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}