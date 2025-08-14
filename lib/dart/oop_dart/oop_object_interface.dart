abstract class Printable {
  void printData();
}

class DataPrinter implements Printable {
  @override
  void printData() {
    print("Printing data");
  }
}

void main() {
  Printable printer = DataPrinter();
  printer.printData(); // In: Printing data
}