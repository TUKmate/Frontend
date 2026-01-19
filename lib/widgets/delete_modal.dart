import 'dart:ui';
import 'package:flutter/material.dart';

// 이 위젯을 호출하여 모달을 띄웁니다.
void showDeleteConfirmModal(BuildContext context, VoidCallback onDelete) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent, // 배경 투명하게 (BackdropFilter 효과 위해)
    isScrollControlled: true, // 전체 화면 높이 제어 가능하도록
    builder: (context) {
      return const DeleteConfirmModal();
    },
  ).then((value) {
    // 모달이 닫힌 후 처리할 로직 (옵션)
    if (value == true) {
      onDelete();
    }
  });
}

class DeleteConfirmModal extends StatelessWidget {
  const DeleteConfirmModal({super.key});

  @override
  Widget build(BuildContext context) {
    // 색상 정의
    const Color primaryColor = Color(0xFF1758A8);
    const Color secondaryColor = Color(0xFF068FD3);
    const Color textMainColor = Color(0xFF111418);
    const Color textSubColor = Color(0xFF64748B);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3), // 배경 블러 효과
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.08),
              blurRadius: 40,
              offset: Offset(0, -10),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min, // 내용만큼만 높이 차지
          children: [
            // 드래그 핸들
            Container(
              width: 48,
              height: 6,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(100),
              ),
            ),

            // 아이콘
            Container(
              width: 72,
              height: 72,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.delete_outline,
                size: 36,
                color: secondaryColor,
              ),
            ),

            // 제목
            const Text(
              "정말 삭제할까요?",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: textMainColor,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),

            // 설명 텍스트
            const Text(
              "삭제된 글은 복구할 수 없습니다.\n신중하게 결정해 주세요.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: textSubColor,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),

            // 버튼 영역
            Row(
              children: [
                // 취소 버튼
                Expanded(
                  child: SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context, false), // 닫기 (취소)
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF1F5F9), // slate-100
                        foregroundColor: const Color(0xFF475569), // slate-600
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        "취소",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // 삭제 버튼
                Expanded(
                  child: SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context, true), // 닫기 (삭제 확인)
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 4,
                        shadowColor: primaryColor.withValues(alpha: 0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        "삭제",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // 하단 여백 (Safe Area 대응용)
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
}

// --- 테스트용 메인 화면 예제 (실제 사용 시 필요 없음) ---
class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: const Text("Delete Modal Test")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // 모달 호출 예시
            showDeleteConfirmModal(context, () {
              // 삭제 확인 시 실행될 로직
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("삭제되었습니다.")),
              );
            });
          },
          child: const Text("삭제 모달 열기"),
        ),
      ),
    );
  }
}