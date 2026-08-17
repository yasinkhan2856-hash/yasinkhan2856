// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;

void openPlatformUrl(String url) {
  final anchor = html.AnchorElement(href: url)
    ..target = '_blank'
    ..rel = 'noopener noreferrer';
  html.document.body?.append(anchor);
  anchor.click();
  anchor.remove();
}
