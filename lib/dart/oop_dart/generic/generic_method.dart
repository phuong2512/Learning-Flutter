T getFirst<T>(List<T> list) {
  if (list.isEmpty) throw Exception("List is empty");
  return list[0];
}

void main() {
  var numbers = [1, 2, 3];
  var names = ["Alice", "Bob", "Charlie"];

  print(getFirst(numbers)); // In: 1
  print(getFirst(names)); // In: Alice
}