import 'package:flutter/material.dart';

class ColorUtils {
  /// Converts a hex string to a Color object.
  /// Accepts formats: '#RRGGBB', '#AARRGGBB', 'RRGGBB', 'AARRGGBB', 'Color(0xFFRRGGBB)', 'Color(0xAARRGGBB)'
  static Color colorFromHex(String hexColor) {
    try {
      // Remove 'Color(' and ')' if present
      if (hexColor.startsWith('Color(') && hexColor.endsWith(')')) {
        hexColor = hexColor.substring(6, hexColor.length - 1);
      }

      // Handle '0x' prefix
      if (hexColor.startsWith('0x')) {
        hexColor = hexColor.substring(2);
      }

      // Remove '#' if present
      if (hexColor.startsWith('#')) {
        hexColor = hexColor.substring(1);
      }

      // Validate hex length
      if (hexColor.length != 6 && hexColor.length != 8) {
        print('Invalid hex color format: $hexColor (length: ${hexColor.length})');
        return Colors.grey;
      }

      // Add alpha channel if missing
      final colorHex = hexColor.length == 6 ? 'FF$hexColor' : hexColor;

      // Parse the color
      return Color(int.parse('0x$colorHex'));
    } catch (e) {
      print('Error parsing color "$hexColor": $e');
      return Colors.grey;
    }
  }
}