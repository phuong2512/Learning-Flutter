void main() {
  Set<String> student1 = {};
  Set<String> student2 = {'Charlie', 'Dave', 'Alice'};
  Set<String> teacher1 = {'Eve', 'Frank', 'Grace'};
  Set<String> teacher2 = Set.from(teacher1);
  
  print('Set rỗng: $student1');
  print('Set có giá trị: $student2');
  print('Set từ 1 set khác: $teacher2\n');
  
  // add
  student1.add('Alice');
  student1.add('Bob');
  student1.add('Alice');
  print('Sau khi thêm Alice, Bob: $student1\n');

  // contains
  print('Có Alice không? ${student1.contains('Alice')}'); 
  print('Có Charlie không? ${student1.contains('Charlie')}\n');

  // remove
  student1.remove('Bob');
  print('Sau khi xóa Bob: $student1\n');

  // union
  Set<String> allstudent = student1.union(student2);
  print('Tất cả sinh viên: $allstudent\n');

  //intersection
  Set<String> commonstudent = student2.intersection(student1);
  print('Sinh viên trùng tên: $commonstudent\n');

  // difference
  Set<String> uniqueVips = student2.difference(student1);
  print('Sinh viên không trùng tên: $uniqueVips\n');

  // Xóa toàn bộ phần tử bằng clear
  student1.clear();
  print('Sau khi xóa hết sinh viên: $student1');
}