extension StringExtension on String {
  String get capitalizeFirstLetter {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  String replaceUnderscoresWithSpaces() {
    return replaceAll('_', ' ');
  }
}
