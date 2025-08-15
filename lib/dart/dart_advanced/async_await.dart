Future<String> getName() async {
  await Future.delayed(Duration(seconds: 3));
  return "Phương";
}

void main() async{
  print("Truy cập thông tin người dùng...");
  try {
    // var name = int.parse(await getName()); //lỗi
    var name = await getName();
    print("Tên người dùng: $name");
  } catch (e) {
    print("Lỗi: $e");
  }
}