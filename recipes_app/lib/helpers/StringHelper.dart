String truncateString(String text, int maxLength) {
  if (text.length <= maxLength) return text;

  List<String> words = text.split(' ');
  StringBuffer truncatedText = StringBuffer();

  int currentLength = 0;
  for (String word in words) {
    if (currentLength + word.length + (truncatedText.isNotEmpty ? 1 : 0) >
        maxLength) {
      break;
    }

    if (truncatedText.isNotEmpty) {
      truncatedText.write(' ');
    }
    truncatedText.write(word);

    currentLength += word.length + (truncatedText.isNotEmpty ? 1 : 0);
  }

  truncatedText.write('...');
  return truncatedText.toString();
}
