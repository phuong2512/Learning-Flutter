class Box<T> {
  T value;

  Box(this.value);

  T getValue() => value;
}

void main() {
  var intBox = Box<int>(123);
  var stringBox = Box<String>("Hello");

  print(intBox.getValue()); // In: 123
  print(stringBox.getValue()); // In: Hello
}