import 'package:flutter/widgets.dart';

String rgbToHex(Color color) {
  final r = ((color.r * 255).round() & 0xff).toRadixString(16).padLeft(2, '0');
  final g = ((color.g * 255).round() & 0xff).toRadixString(16).padLeft(2, '0');
  final b = ((color.b * 255).round() & 0xff).toRadixString(16).padLeft(2, '0');

  return '$r$g$b';
}

Color hexToColor(String hex) {
  return Color(int.parse(hex, radix: 16) + 0xFF000000);
}
