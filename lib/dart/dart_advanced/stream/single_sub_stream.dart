import 'dart:async';

Stream<int> myStream() {
  final myStreamController = StreamController<int>();
  Future(() async {
    var counter = 0;
    for (var i = 0; i < 5; i++) {
      await Future.delayed(Duration(seconds: 1));
      counter++;
      myStreamController.add(counter);
    }
    myStreamController.close();
  });

  return myStreamController.stream;
}

void main() async {
  final stream = myStream();
  print('Bắt đầu đếm từ 1 đến 5');
  stream.listen(
    (count) => print(count),
    onDone: () => print('Hoàn tất'),
    onError: (e) => print('Lỗi: $e'),
  );

}
