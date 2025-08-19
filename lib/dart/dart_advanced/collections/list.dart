void main() {
  List<int> list = [];
  List<int> integer = [10, 20, 30, 40, 50];
  List<int> fixedList = List.filled(5, 10);
  List<int> generatedList = List.generate(5, (index) => index * 2);

  print('List rỗng: $list');
  print('List số nguyên: $integer');
  print('List cố định: $fixedList');
  print('List cố định tạo bằng generate: $generatedList\n');

  print('Phần tử đầu tiên: ${integer[0]}');
  print('Phần tử thứ ba: ${integer[2]}');

  // add
  integer.add(60);
  //fixedList.add(60); //Lỗi
  print('List sau khi thêm: $integer');

  // remove
  integer.remove(20);
  print('List sau khi xóa 20: $integer');

  // length
  print('Độ dài của List: ${integer.length}');

  // insert
  integer.insert(2, 5);
  print('List sau khi thêm 5 vào vị trí thứ 3: $integer');

  // map
  List<int> doubledList = integer.map((n) => n * 2).toList();
  print('List sau khi nhân đôi: $doubledList');

  // where
  List<int> evenList = integer.where((n) => n % 2 == 0).toList();
  print('List số chẵn: $evenList');

  // sort
  integer.sort();
  print('List sau khi sắp xếp: $integer');

  // isNotEmpty
  print('List có phần tử không? ${integer.isNotEmpty}');

  // clear
  integer.clear();
  print('List sau khi xóa hết: $integer');

  // isEmpty
  print('List rỗng không? ${integer.isEmpty}');

}