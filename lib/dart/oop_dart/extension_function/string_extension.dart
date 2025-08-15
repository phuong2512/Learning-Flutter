extension StringExtension on String {
  String upperCaseString() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}

void main() {
  String text = "hElLo";
  print(text.upperCaseString()); // In: Hello
}
