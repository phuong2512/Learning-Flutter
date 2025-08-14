// Định nghĩa một abstract class với một phương thức trừu tượng duy nhất
abstract class StringProcessor {
  void process(String data);
}

// Tạo một class triển khai interface này
class Printer implements StringProcessor {
  @override
  void process(String data) {
    print("In: $data"     );
  }
}

// Hàm nhận một StringProcessor và gọi phương thức process của nó
void executeProcessor(StringProcessor processor, String data) {
  processor.process(data);
}

void main() {
  // Tạo instance của Printer và sử dụng
  var printer = Printer();
  executeProcessor(printer, "Xin chào, Dart!");  // Kết quả: In: Xin chào, Dart!

  // Sử dụng lambda thay cho class
  // executeProcessor((String data) => print("Lambda: $data"), "Xin chào, Lambda!");
}