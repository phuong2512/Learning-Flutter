void main() {
  Map<String, int> point = {};
  print('Map rỗng: $point');

  Map<String, String> userInfo = {
    'name': 'Tran Van P',
    'email': 'tvp@gmail.com',
    'phoneNumber': '0987654321'
  };
  print('Map thông tin người dùng: $userInfo');
  print('Tên người dùng: ${userInfo['name']}');


  Map<String, String> copyUserInfo = Map.from(userInfo);
  print('Map sao chép từ thông tin người dùng: $copyUserInfo');
  print('Email người dùng: ${copyUserInfo['email']}');

  point['Toan'] = 90;
  point['Van'] = 75;
  point['Anh'] = 88;
  print('\nMap điểm môn học sau khi thêm: $point');

  // putIfAbsent
  point.putIfAbsent('Ly', () => 85);
  print('Điểm Lý mới: ${point['Ly']}');
  point.putIfAbsent('Toan', () => 95);
  print('Điểm Toán mới: ${point['Toan']}');

  // remove
  String? emailDeleted = userInfo.remove('email');
  print('Email đã xóa: $emailDeleted');
  print('Map thông tin người dùng: $userInfo');

  // clear
  point.clear();
  print(point);
}