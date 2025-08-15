extension GetSetExtension on List<String> {
  // // Getter
  // bool get isEven => this % 2 == 0;
  //
  // // Setter (ít dùng, vì int là immutable)
  // set doubleValue(double value) {
  //   // Không thể thay đổi giá trị của int, chỉ để minh họa
  //   print("Cannot set value for immutable int: $value");
  // }

  // Getter: Trả về chuỗi dài nhất trong danh sách
  String get longestString {
    if (isEmpty) return "";
    return reduce((a, b) => a.length >= b.length ? a : b);
  }

  // Setter: Thêm một chuỗi vào danh sách nếu nó dài hơn 3 ký tự
  set addLongString(String value) {
    if (value.length > 3) {
      add(value);
    } else {
      print("String '$value' is too short to add (must be > 3 characters).");
    }
  }
}

void main() {
  // int number = 4;
  // print(number.isEven); // In: true
  // number.doubleValue = 8.0; // In: Cannot set value for immutable int: 8.0

  // Tạo một danh sách String
  var fruits = ["apple", "banana", "kiwi", "strawberry"];

  // Sử dụng getter
  print(fruits.longestString); // In: strawberry (chuỗi dài nhất)

  // Sử dụng setter
  fruits.addLongString = "mango"; // Thêm thành công
  print(fruits); // In: [apple, banana, kiwi, strawberry, mango]

  fruits.addLongString = "fig"; // Không thêm được vì quá ngắn
  // In: String 'fig' is too short to add (must be > 3 characters).
  print(fruits); // In: [apple, banana, kiwi, strawberry, mango]
}
