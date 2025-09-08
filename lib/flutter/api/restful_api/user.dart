class User {
  final String id;
  final String name;
  final int age;
  final String email;
  final String? phone;
  final Map<String, dynamic>? address;

  User({
    required this.id,
    required this.name,
    required this.age,
    required this.email,
    this.phone,
    this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    name: json['name'],
    age: json['age'],
    email: json['email'],
    phone: json['phone'],
    address: json['address'],
  );

  Map<String, dynamic> toJson() {
    final data = {
      "name": name,
      "age": age,
      "email": email,
      "phone": phone,
      "address": address,
    };
    if (id.isNotEmpty) data["id"] = id;
    return data;
  }

}
