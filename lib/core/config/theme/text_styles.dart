import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// All App custom [TextStyle]
///
class TextStyles {
  /// fontSize [28], fontWeight[700] - Main title
  static TextStyle mainTitle = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  /// fontSize [16], fontWeight[400], color[Grey] - Secondary text
  static TextStyle secondaryText = GoogleFonts.poppins(
    fontSize: 16,
    color: Colors.grey[600],
  );

  /// fontSize [16], fontWeight[600], color[Primary] - Link text
  static TextStyle linkText = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  /// fontSize [14], fontWeight[400], color[Grey] - Small grey text
  static TextStyle smallGreyText = GoogleFonts.poppins(
    color: Colors.grey[600],
  );
} 