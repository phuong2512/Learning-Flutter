void main() {
  // Build-in Exception
  try {
    int.parse('abc');
  } on FormatException {
    print('Lỗi định dạng');
  // } catch (e) {
  //   print('Lỗi: $e');
  }

  // Custom Exception
  try {
    throw CustomException('Lỗi tự định nghĩa');
  } on CustomException catch (e) {
    print('Lỗi tự định nghĩa: ${e.message}');
  // } catch (e) {
  //   print('$e');
  }
}

class CustomException {
  final String message;
  CustomException(this.message);

  @override
  String toString() => 'CustomException: $message';
}
