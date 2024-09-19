int calculateReadingTime(String content) {

  final wordCount = content.split(RegExp(r'\s+'));

  final readingTime = wordCount.length / 200;
  return readingTime.ceil();
}
