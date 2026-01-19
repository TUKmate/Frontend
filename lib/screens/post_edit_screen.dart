import 'package:flutter/material.dart';

class PostEditScreen extends StatefulWidget {
  final int postId;
  const PostEditScreen({super.key, required this.postId});

  @override
  State<PostEditScreen> createState() => _PostEditScreenState();
}

class _PostEditScreenState extends State<PostEditScreen> {
  // --- 상태 변수들 (기본값 설정) ---
  final TextEditingController _titleController = TextEditingController(text: "조용하고 깔끔한 룸메 구합니다 (비흡연)");
  final TextEditingController _contentController = TextEditingController(text: "안녕하세요! 23학번 기계공학과 학생입니다. 서로 배려하며 지낼 룸메이트 구합니다.");

  String _selectedDorm = "TIP 하우스";
  
  // 상세 조건
  String _mbtiIE = "E"; String _mbtiNS = "N"; 
  String _mbtiTF = "T"; String _mbtiJP = "P"; // HTML 예시에 맞춰 기본값 설정
  
  String _birthYear = "04년생";
  String _studentId = "23학번";
  String _sleepTime = "24시 ~ 01시";
  String _wakeTime = "08시 ~ 09시";
  String _smoking = "비흡연";
  String _bug = "가능";
  String _showerStyle = "저녁";
  String _showerTime = "빠름";
  String _sleepSensitivity = "둔감";
  String _visitFrequency = "매주";
  
  // 잠버릇 (중복 선택)
  final Map<String, bool> _sleepHabits = {
    "없음": true,
    "코골이": false,
    "이갈이": false,
    "잠꼬대": false,
    "뒤척임": false,
  };

  String _gameFrequency = "가끔";
  String _cleaningFrequency = "보통";
  String _discordFrequency = "안함";
  String _inviteFriend = "사전 협의 시 가능";

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 색상 정의
    const Color primaryColor = Color(0xFF1758A8);
    const Color accentColor = Color(0xFF01B3CD);
    const Color backgroundColor = Color(0xFFF6FAFF);
    const Color surfaceColor = Color(0xFFFFFFFF);
    const Color textSubColor = Color(0xFF64748B);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: surfaceColor.withValues(alpha: 0.9),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          color: primaryColor,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "글 수정",
          style: TextStyle(
            color: primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // 삭제 로직
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red[400],
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            child: const Text("삭제", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.blue[50], height: 1),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. 기본 정보 섹션
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(24),
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
                  _buildSectionTitle(Icons.domain, "기본 정보", textSubColor),
                  const SizedBox(height: 16),
                  
                  _buildLabel("기숙사 선택"),
                  Row(
                    children: [
                      Expanded(child: _buildChip("TIP 하우스", _selectedDorm, (val) => setState(() => _selectedDorm = val))),
                      const SizedBox(width: 8),
                      Expanded(child: _buildChip("2기숙사", _selectedDorm, (val) => setState(() => _selectedDorm = val))),
                    ],
                  ),
                  const SizedBox(height: 16),

                  _buildLabel("제목"),
                  TextField(
                    controller: _titleController,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    decoration: _inputDecoration("룸메이트 모집 제목"),
                  ),
                  const SizedBox(height: 16),

                  _buildLabel("내용"),
                  TextField(
                    controller: _contentController,
                    maxLines: 5,
                    style: const TextStyle(fontSize: 15, height: 1.5),
                    decoration: _inputDecoration("내용을 입력해주세요."),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 2. 상세 조건 체크리스트 섹션
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(24),
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
                  _buildSectionTitle(Icons.checklist_rtl, "상세 조건 체크리스트", textSubColor),
                  const SizedBox(height: 20),

                  // MBTI
                  _buildLabel("MBTI"),
                  Row(
                    children: [
                      Expanded(child: _buildChip("E", _mbtiIE, (v) => setState(() => _mbtiIE = v), isSmall: true)), const SizedBox(width: 4),
                      Expanded(child: _buildChip("I", _mbtiIE, (v) => setState(() => _mbtiIE = v), isSmall: true)), const SizedBox(width: 4),
                      Expanded(child: _buildChip("S", _mbtiNS, (v) => setState(() => _mbtiNS = v), isSmall: true)), const SizedBox(width: 4),
                      Expanded(child: _buildChip("N", _mbtiNS, (v) => setState(() => _mbtiNS = v), isSmall: true)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(child: _buildChip("T", _mbtiTF, (v) => setState(() => _mbtiTF = v), isSmall: true)), const SizedBox(width: 4),
                      Expanded(child: _buildChip("F", _mbtiTF, (v) => setState(() => _mbtiTF = v), isSmall: true)), const SizedBox(width: 4),
                      Expanded(child: _buildChip("J", _mbtiJP, (v) => setState(() => _mbtiJP = v), isSmall: true)), const SizedBox(width: 4),
                      Expanded(child: _buildChip("P", _mbtiJP, (v) => setState(() => _mbtiJP = v), isSmall: true)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // 생년 & 학번
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("생년"),
                            _buildDropdown(_birthYear, ["00년생", "01년생", "02년생", "03년생", "04년생", "05년생"], (v) => setState(() => _birthYear = v!)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("학번"),
                            _buildDropdown(_studentId, ["18학번", "19학번", "20학번", "21학번", "22학번", "23학번"], (v) => setState(() => _studentId = v!)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // 취침 & 기상
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("취침 시간"),
                            _buildDropdown(_sleepTime, ["23시 이전", "24시 ~ 01시", "02시 이후"], (v) => setState(() => _sleepTime = v!)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("기상 시간"),
                            _buildDropdown(_wakeTime, ["08시 이전", "08시 ~ 09시", "10시 이후"], (v) => setState(() => _wakeTime = v!)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // 흡연
                  _buildLabel("흡연 여부"),
                  Row(children: [
                    Expanded(child: _buildChip("비흡연", _smoking, (v) => setState(() => _smoking = v), isSmall: true)), const SizedBox(width: 8),
                    Expanded(child: _buildChip("흡연", _smoking, (v) => setState(() => _smoking = v), isSmall: true)), const SizedBox(width: 8),
                    Expanded(child: _buildChip("전자담배", _smoking, (v) => setState(() => _smoking = v), isSmall: true)),
                  ]),
                  const SizedBox(height: 24),

                  // 그리드 항목들
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 2.5,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 24,
                    children: [
                      _buildGridItem("벌레 잡기", ["가능", "불가"], _bug, (v) => setState(() => _bug = v)),
                      _buildGridItem("샤워 스타일", ["아침", "저녁"], _showerStyle, (v) => setState(() => _showerStyle = v)),
                      _buildGridItem("샤워 시간", ["빠름", "느림"], _showerTime, (v) => setState(() => _showerTime = v)),
                      _buildGridItem("잠귀", ["예민", "둔감"], _sleepSensitivity, (v) => setState(() => _sleepSensitivity = v)),
                    ],
                  ),
                  const SizedBox(height: 24),

                  _buildLabel("본가 방문 주기"),
                  Row(children: [
                    Expanded(child: _buildChip("매주", _visitFrequency, (v) => setState(() => _visitFrequency = v), isSmall: true)), const SizedBox(width: 8),
                    Expanded(child: _buildChip("격주", _visitFrequency, (v) => setState(() => _visitFrequency = v), isSmall: true)), const SizedBox(width: 8),
                    Expanded(child: _buildChip("월 1회", _visitFrequency, (v) => setState(() => _visitFrequency = v), isSmall: true)),
                  ]),
                  const SizedBox(height: 24),

                  // 잠버릇 (다중 선택)
                  _buildLabel("잠버릇 (중복 선택)"),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _sleepHabits.keys.map((habit) {
                      final isSelected = _sleepHabits[habit]!;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            // '없음'을 선택하면 다른거 해제, 다른거 선택하면 '없음' 해제 로직 등은 필요에 따라 추가
                            _sleepHabits[habit] = !isSelected;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? accentColor.withValues(alpha: 0.1) : Colors.grey[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected ? accentColor : Colors.grey[200]!,
                            ),
                          ),
                          child: Text(
                            habit,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? accentColor : Colors.grey[400],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // 빈도 수평 항목들
                  _buildFrequencyRow("게임 빈도", _gameFrequency, (v) => setState(() => _gameFrequency = v)),
                  const SizedBox(height: 16),
                  _buildFrequencyRow("청소 빈도", _cleaningFrequency, (v) => setState(() => _cleaningFrequency = v)),
                  const SizedBox(height: 16),
                  _buildFrequencyRow("디코(음성채팅)", _discordFrequency, (v) => setState(() => _discordFrequency = v)),
                  const SizedBox(height: 24),

                  // 친구 초대
                  _buildLabel("친구 초대 성향"),
                  Row(children: [
                    Expanded(child: _buildChip("절대 불가", _inviteFriend, (v) => setState(() => _inviteFriend = v), isSmall: true)), 
                    const SizedBox(width: 8),
                    Expanded(child: _buildChip("사전 협의 시 가능", _inviteFriend, (v) => setState(() => _inviteFriend = v), isSmall: true)),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: surfaceColor.withValues(alpha: 0.9),
          border: Border(top: BorderSide(color: Colors.blue[50]!.withValues(alpha: 0.6))),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              // 수정 완료 로직
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: accentColor,
              foregroundColor: Colors.white,
              elevation: 4,
              shadowColor: accentColor.withValues(alpha: 0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, size: 20),
                SizedBox(width: 8),
                Text(
                  "수정 완료",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- 위젯 헬퍼 메서드들 ---

  Widget _buildSectionTitle(IconData icon, String title, Color color) {
    return Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 6),
        Text(
          title,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF64748B)),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[400]),
      filled: true,
      fillColor: const Color(0xFFF6FAFF), // tuk-bg
      contentPadding: const EdgeInsets.all(16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFF068FD3), width: 1.5), // secondary color ring
      ),
    );
  }

  // 단일 선택 칩 (Button)
  Widget _buildChip(String label, String groupValue, Function(String) onSelected, {bool isSmall = false}) {
    final bool isSelected = label == groupValue;
    final Color secondaryColor = const Color(0xFF068FD3);

    return GestureDetector(
      onTap: () => onSelected(label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: isSmall ? 10 : 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? secondaryColor : Colors.grey[100]!,
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: secondaryColor.withValues(alpha: 0.1), blurRadius: 4, offset: const Offset(0, 2))]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: isSmall ? 12 : 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? secondaryColor : Colors.grey[400],
          ),
        ),
      ),
    );
  }

  // 그리드 아이템 (라벨 + 2개 버튼)
  Widget _buildGridItem(String title, List<String> options, String currentVal, Function(String) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(title),
        Expanded(
          child: Row(
            children: [
              Expanded(child: _buildChip(options[0], currentVal, onSelect, isSmall: true)),
              const SizedBox(width: 6),
              Expanded(child: _buildChip(options[1], currentVal, onSelect, isSmall: true)),
            ],
          ),
        ),
      ],
    );
  }

  // 빈도 선택 행 (라벨 + 3개 버튼)
  Widget _buildFrequencyRow(String title, String currentVal, Function(String) onSelect) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF64748B))),
        Row(
          children: ["안함", "가끔", "자주"].map((opt) {
            final isSelected = currentVal == opt;
            return GestureDetector(
              onTap: () => onSelect(opt),
              child: Container(
                margin: const EdgeInsets.only(left: 6),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.grey[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF068FD3) : Colors.grey[100]!,
                  ),
                ),
                child: Text(
                  opt,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? const Color(0xFF068FD3) : Colors.grey[400],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // 드롭다운
  Widget _buildDropdown(String value, List<String> items, Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.expand_more, color: Color(0xFF068FD3)),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF068FD3)),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}