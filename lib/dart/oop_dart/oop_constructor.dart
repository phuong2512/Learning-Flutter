class Car {
  String model;
  int year;

  // Generative constructor
  Car(this.model, this.year);

  // Named constructor
  Car.model_2023(String model) : this(model, 2023);
}

class SingletonClass {
  // Instance tĩnh để lưu trữ
  static final SingletonClass _instance = SingletonClass._internal();

  // Factory constructor
  factory SingletonClass() {
    return _instance; // Trả về instance duy nhất
  }

  // Private generative constructor
  SingletonClass._internal();

  void sayHello() {
    print("Hello from Singleton!");
  }
}

class Color {
  final String name;
  static final Map<String, Color> _cache = {};

  // Factory constructor với caching
  factory Color(String name) {
    if (_cache.containsKey(name)) {
      return _cache[name]!;
    }
    final color = Color._internal(name);
    _cache[name] = color;
    return color;
  }

  Color._internal(this.name);
}

class User {
  final String id;
  final String name;

  User(this.id, this.name);

  // Factory constructor từ JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['id'] as String, json['name'] as String);
  }
}

abstract class Animal {
  String getSound();

  // Factory constructor
  factory Animal(String type) {
    if (type == "Dog") return Dog();
    if (type == "Cat") return Cat();
    throw Exception("Unknown animal type");
  }
}

class Dog implements Animal {
  @override
  String getSound() => "Woof!";
}

class Cat implements Animal {
  @override
  String getSound() => "Meow!";
}

class Point {
  double x, y;

  Point(this.x, this.y);

  // Redirecting constructor
  Point.redirectCons() : this(0, 0);
}

class Rectangle {
  final double width, height;

  // Generative constructor
  Rectangle(this.width, this.height);

  // Redirecting constructor cho hình vuông
  Rectangle.square(double size) : this(size, size);

  Rectangle.rec(double w, double h) : this(w, h);
}

class Animal2 {
  final String type;

  Animal2(this.type);

  Animal2.named() : this("Unknown");
}

class Dog2 extends Animal2 {
  final String breed;

  Dog2(this.breed, String type) : super(type);

  // Redirecting constructor
  Dog2.named(String breed) : this(breed, "Canine");
}

void main() {
  // var car1 = Car("Toyota", 2020);
  // var car2 = Car.model_2023("Honda");
  // print(car1.model); // In: Toyota
  // print(car2.year); // In: 2023
  // print(car2.model); // In: 2023

  // var s1 = SingletonClass();
  // var s2 = SingletonClass();
  // print(identical(s1, s2)); // In: true (cùng instance)
  // s1.sayHello(); // In: Hello from Singleton!

  // var red1 = Color("Red");
  // var red2 = Color("Red");
  // var blue = Color("Blue");
  // var blue2 = Color("Blue");
  // print(identical(red1, red2)); // In: true (tái sử dụng instance)
  // print(identical(red1, blue)); // In: false (instance khác)
  // print(identical(blue, blue2)); // In: false (instance khác)
  // print(red1.name); // In: Red

  // var json = {'id': '123', 'name': 'Alice'};
  // var user = User.fromJson(json);
  // print(user.id); // In: 123
  // print(user.name); // In: Alice

  // var animal = Animal("Dog");
  // var animal2 = Animal("Cat");
  // print(animal.getSound()); // In: Woof!
  // print(animal2.getSound()); // In: Meow!

  // var point = Point.redirectCons();
  // print(point.x); // In: 0
  // print(point.y); // In: 0

  // var square = Rectangle.square(5);
  // var rectangle = Rectangle.rec(5, 10);
  // print("Width: ${square.width}, Height: ${square.height}"); // In: Width: 5, Height: 5
  // print("Width: ${rectangle.width}, Height: ${rectangle.height}");

  var dog = Dog2.named("Labrador");
  print("Breed: ${dog.breed}, Type: ${dog.type}");
}
