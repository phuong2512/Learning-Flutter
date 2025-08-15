class Point {
  final double xPoint, yPoint;

  Point(this.xPoint, this.yPoint);
}

extension OperatorExtension on Point {
  Point operator +(Point other) {
    return Point(xPoint + other.xPoint, yPoint + other.yPoint);
  }
}

void main() {
  var p1 = Point(1, 2);
  var p2 = Point(3, 4);
  var p3 = p1 + p2;
  print("x: ${p3.xPoint}, y: ${p3.yPoint}"); // In: x: 4.0, y: 6.0
}
