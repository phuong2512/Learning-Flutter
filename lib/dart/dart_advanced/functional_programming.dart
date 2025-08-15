void main() {
// Hàm thuần
  String hello(String name) => "Hello, $name";
  print(hello("Nam")); //luôn in ra "Hello, Nam" với "Nam" là tham số truyền vo

// Immutable
  final String name = "Long";
  print(hello(name));

// Higher-order functions
  String greet(String name, String Function(String) sayHello) => sayHello(name);
  var hightOrder = greet("Phương", hello);
  // var hightOrder = greet("Phương", (name) => "Hello, $name");
  print(hightOrder);

  List<int> list = [1, 2, 3, 4, 5];
  var whereEven = list.where((n) => n % 2 == 0).toList();
  print(whereEven);

  var mapList = list.map((n) => n * 2).toList();
  print(mapList);

// Statelessness
  List<int> processNumbers(List<int> numbers) {
    return numbers
        .where((n) => n.isEven)
        .map((n) => n * 2)
        .toList();
  }

  final numbers = [1, 2, 3, 4, 5, 6];
  final result = processNumbers(numbers);
  print(result);
  print(numbers);
}
