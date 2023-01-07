extension FilePath on String {
  String get fileName => split('/').last;
}
