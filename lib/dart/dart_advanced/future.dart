Future<String> fetchUserData(int userId) async {
  await Future.delayed(Duration(seconds: 2));
  if (userId < 0) throw Exception("ID không hợp lệ");
  return "Truy cập dữ liệu người dùng với id: $userId";
}

void main() async {
  print('Bắt đầu lấy dữ liệu...');
  try {
    final data1 = await fetchUserData(123456);
    print(data1);
    print('Hoàn thành lấy dữ liệu\n');

    print('Bắt đầu lấy dữ liệu...');
    final data2 = await fetchUserData(-123456);
    print(data2);
    print('Hoàn thành lấy dữ liệu');
  } catch (e) {
    print("Lỗi: $e");
  }
}
