void main() {
  sum(int a, int b) {
    return a + b;
  }

  print(sum(5, 10)); //15

  div(int a, int b) => a ~/ b;
  print(div(10, 5)); //2

  int num = 10;
  add(int bonus) => num += bonus;
  print(add(40)); //50

  List<int> nums = [1, 2, 3];
  var doubledNums = nums.map((n) => n * 2).toList();
  print(doubledNums); // In: [2, 4, 6]
}
