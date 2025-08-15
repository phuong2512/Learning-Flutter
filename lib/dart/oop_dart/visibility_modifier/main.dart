// File: main.dart
import 'visibility_modifier_private.dart';

void main() {
  var person = Person("Alice");
  // print(person._name); // Lỗi: '_name' is not accessible
  // person._sayHello(); // Lỗi: '_sayHello' is not accessible
  person.publicMethod(); // Hợp lệ: In: Hello, I'm Alice
}
