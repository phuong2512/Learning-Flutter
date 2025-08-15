//Thêm 1 phương thức vào lớp int
extension IntExtensions on int {
  bool isEvenNumber() {
    return this % 2 == 0;
  }
}

void main() {
  int number1 = 10;
  int number2 = 7;

  print('$number1 là số chẵn? ${number1.isEvenNumber()}'); // Kết quả: 10 là số chẵn? true
  print('$number2 là số chẵn? ${number2.isEvenNumber()}'); // Kết quả: 7 là số chẵn? false
}