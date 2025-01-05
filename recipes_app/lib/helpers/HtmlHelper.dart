import 'package:html/parser.dart' as html_parser;

String stripHtmlTags(String? htmlString) {
  if (htmlString == null) return '';
  final document = html_parser.parse(htmlString);
  return document.body?.text ?? '';
}