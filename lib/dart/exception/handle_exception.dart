import 'dart:async';

Future<String> downloadData() async {
  await Future.delayed(Duration(seconds: 5));
  return "Dữ liệu tải xuống thành công!";
}

void main() async {
  try {
    var result = await downloadData().timeout(Duration(seconds: 2),
        onTimeout: () {
          throw TimeoutException("Tốn quá nhiều thời gian để tải xuống, hãy thử lại sau!");
        });
    print(result);
  } on TimeoutException catch (e) {
    print("Lỗi: $e");
  } finally {
    print("Đóng trình tải xuống.");
  }
}