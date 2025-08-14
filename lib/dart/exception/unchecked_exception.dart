void main() {
  try {
    String string = "abc";
    int number = int.parse(string);
    print("Số hợp lệ: $number");
  } catch (e) {
    print("Lỗi: $e");
  }
}
