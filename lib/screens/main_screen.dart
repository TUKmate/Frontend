import 'package:flutter/material.dart';
// 각 화면 임포트 (파일 경로에 맞게 수정하세요)
import 'home_screen.dart';
// import 'write_screen.dart'; // 글쓰기 화면 파일이 있다면 주석 해제
// import 'chat_screen.dart';  // 채팅 화면 파일이 있다면 주석 해제
// import 'profile_screen.dart'; // 마이페이지 화면 파일이 있다면 주석 해제

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // 현재 선택된 탭 인덱스 (기본값: 0 -> 홈)
  int _selectedIndex = 0;

  // 탭별 화면 리스트
  // 파일이 없는 화면은 임시로 Center 위젯을 넣어두었습니다.
  final List<Widget> _screens = [
    const HomeScreen(),      // 0: 홈
    const Center(child: Text("글쓰기 화면")), // 1: 글쓰기 (임시)
    const Center(child: Text("채팅 화면")),   // 2: 채팅 (임시)
    const Center(child: Text("마이페이지 화면")), // 3: 마이페이지 (임시)
    // const ProfileScreen(), // 파일이 있다면 위 줄을 지우고 이 줄의 주석을 해제하세요.
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 색상 정의 (HTML 디자인과 동일하게 맞춤)
    const Color secondaryColor = Color(0xFF068FD3);

    return Scaffold(
      // body: 현재 선택된 인덱스의 화면을 보여줌
      // IndexedStack을 사용하면 탭 전환 시 화면 상태(스크롤 위치 등)가 유지됩니다.
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),

      // 하단 네비게이션 바 (HTML의 <nav> 부분 구현)
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.95), // bg-white/95
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)), // rounded-t-3xl
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02), // shadow-[0_-5px_20px_rgba(0,0,0,0.02)]
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
          border: Border(top: BorderSide(color: Colors.blue[50]!)), // border-t border-blue-50
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // px-4 pb-4 (vertical 조정함)
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBottomNavItem(Icons.home_filled, "홈", 0, secondaryColor),
                _buildBottomNavItem(Icons.edit_square, "글쓰기", 1, secondaryColor),
                _buildBottomNavItem(Icons.chat_bubble, "채팅", 2, secondaryColor), // chat_bubble_outline 대신 filled 느낌을 위해
                _buildBottomNavItem(Icons.person, "마이페이지", 3, secondaryColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 하단 네비게이션 아이템 빌더 (HTML의 <button> 부분 구현)
  Widget _buildBottomNavItem(IconData icon, String label, int index, Color activeColor) {
    final bool isSelected = _selectedIndex == index;
    
    // HTML 디자인 참고:
    // 선택됨: text-secondary, filled icon, font-bold
    // 선택안됨: text-gray-400, font-medium
    
    return Expanded(
      child: GestureDetector(
        onTap: () => _onItemTapped(index),
        behavior: HitTestBehavior.opaque, // 터치 영역 확대
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 아이콘 부분
            // 애니메이션 효과: active:scale-90 (Flutter에서는 탭할 때 기본 효과가 있지만, 아이콘 크기/색상 변경으로 상태 표현)
            Icon(
              icon,
              size: 26, // text-[26px]
              color: isSelected ? activeColor : Colors.grey[400],
            ),
            const SizedBox(height: 4), // gap-1 (약 4px)
            // 텍스트 부분
            Text(
              label,
              style: TextStyle(
                fontSize: 11, // text-[11px]
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500, // font-bold vs font-medium
                color: isSelected ? activeColor : Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}