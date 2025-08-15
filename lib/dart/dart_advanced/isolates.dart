import 'dart:isolate';

//hàm sẽ thực hiện trong isolate phụ
void sumTask(SendPort sendPort) {
  int total = 0;
  for (int i = 1; i <= 1000000; i++) {
    total += i;
  }
  sendPort.send(total); //gửi kết quả sang isolate chính
}

void main() async {
  print("Bắt đầu tính tổng");
  var receivePort = ReceivePort();

  //isolate chính spawn isolate phụ
  var isolate = await Isolate.spawn(sumTask, receivePort.sendPort);
  receivePort.listen((message) {
    print("Tổng từ 1 đến 1 triệu: $message");
    isolate.kill();
    receivePort.close();
  });
  print(
    "Nội dung này được in ra trước vì isolate chính chạy song song với isolate phụ",
  );
}
