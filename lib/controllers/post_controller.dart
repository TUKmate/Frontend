import 'package:get/get.dart';
import '../models/post.dart';
import '../services/api_service.dart';

class PostController extends GetxController {
  final _api = Get.find<ApiService>();

  // 상태 변수
  final RxList<Post> posts = <Post>[].obs; // 게시물 목록
  final RxBool isLoading = false.obs; // 로딩 상태

  @override
  void onInit() {
    super.onInit();
    loadPosts(); // 초기화 시 게시물 불러오기
  }

  // 게시물 불러오기
  Future<void> loadPosts() async {
    isLoading.value = true;

    try {
      final data = await _api.getPosts();
      // json 배열 -> Post 객체 리스트 변환
      posts.value = data.map<Post>((json) => Post.fromJson(json)).toList();
    } catch (e) {
      Get.snackbar('오류', '게시물을 불러오는 데 실패했습니다.');
    } finally {
      isLoading.value = false;  // 성공이든 실패든 로딩 끝
    }
  }

  // 새 게시물 작성
  Future<bool> createPost({required String content}) async {
    // 빈 내용 체크
    if (content.trim().isEmpty) return false;

    try {
      final res = await _api.createPost(content, null);
      if (res.statusCode == 201) {
        await loadPosts(); // 게시물 새로고침 (새 게시글이 보이도록)
        return true;
      }
    } catch (e) {
      Get.snackbar('오류', '게시물 작성에 실패했습니다.');
    }
    return false;
  }

  // 게시물 삭제
  Future<void> deletePost(int id) async {
    try {
      final success = await _api.deletePost(id);
      if (success) {
        // 로컬 목록에서 해당 게시글 제거
        posts.removeWhere((post) => post.id == id); 
        Get.snackbar('완료', '게시물이 삭제되었습니다.');
      }
    } catch (e) {
      Get.snackbar('오류', '게시물 삭제에 실패했습니다.');
    }
  }

  // 게시물 북마크 토글
  Future<void> toggleBookmark(int postId) async {
    try {
      final result = await _api.toggleBookmark(postId);
      if (result != null) {
        // 해당 게시글 찾기
        int index = posts.indexWhere((post) => post.id == postId);
        if (index != -1) {
          // 북마크 상태 업데이트
          posts[index] = posts[index].copyWith(
            isBookmarked: result['bookmarked']
          );
        }
      }
    } catch (e) {
      Get.snackbar('오류', '북마크 실패');
    }
  }
}