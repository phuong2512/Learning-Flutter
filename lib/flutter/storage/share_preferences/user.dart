class User {
  final String name;
  final int age;
  final List<String> address;
  final int phoneNumber;

  User({
    required this.name,
    required this.age,
    required this.address,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() => {
    'name': name,
    'age': age,
    'address': address,
    'phoneNumber': phoneNumber,
  };

  factory User.fromMap(Map<String, dynamic> map) => User(
    name: map['name'],
    age: map['age'],
    address: List<String>.from(map['address']),
    phoneNumber: map['phoneNumber'],
  );
}
