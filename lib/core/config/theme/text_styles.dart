import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// All App custom [TextStyle]
///
class TextStyles {
  // MARK: - Headers & Titles

  /// fontSize [28], fontWeight[700] - Main title
  static TextStyle mainTitle = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  /// fontSize [24], fontWeight[700] - Product name
  static TextStyle productName = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  /// fontSize [18], fontWeight[600] - Section title
  static TextStyle sectionTitle = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  // MARK: - Body Text

  /// fontSize [16], fontWeight[400], color[Grey] - Secondary text
  static TextStyle secondaryText = GoogleFonts.poppins(
    fontSize: 16,
    color: Colors.grey[600],
  );

  /// fontSize [16], fontWeight[600] - Bold text
  static TextStyle boldText = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  /// fontSize [16], fontWeight[400] - Regular text
  static TextStyle regularText = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  /// fontSize [16], fontWeight[600], color[Primary] - Link text
  static TextStyle linkText = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  // MARK: - Small Text

  /// fontSize [14], fontWeight[400], color[Grey] - Small grey text
  static TextStyle smallGreyText = GoogleFonts.poppins(
    color: Colors.grey[600],
  );

  /// fontSize [14], fontWeight[400] - Small text
  static TextStyle smallText = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  // MARK: - Error Messages

  /// fontSize [18], fontWeight[400], color[Grey] - Error message
  static TextStyle errorMessage = GoogleFonts.poppins(
    fontSize: 18,
    color: Colors.grey[600],
  );

  /// fontSize [14], fontWeight[400], color[Grey] - Small error message
  static TextStyle smallErrorMessage = GoogleFonts.poppins(
    color: Colors.grey[500],
  );

  // MARK: - Product Specific

  /// fontSize [28], fontWeight[700], color[Primary] - Product price
  static TextStyle productPrice = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  /// fontSize [16], fontWeight[400], color[Grey] - Product description
  static TextStyle productDescription = GoogleFonts.poppins(
    fontSize: 16,
    color: Colors.grey[700],
    height: 1.5,
  );

  /// fontSize [16], fontWeight[600] - Button text
  static TextStyle buttonText = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
} 