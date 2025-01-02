// lib/core/constants/app_typography.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static TextTheme get textTheme => TextTheme(
        displayLarge: _notoSans(
          fontSize: 96,
          fontWeight: FontWeight.w300,
          letterSpacing: -1.5,
          height: 1.17,
        ),
        displayMedium: _notoSans(
          fontSize: 60,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.5,
          height: 1.12,
        ),
        displaySmall: _notoSans(
          fontSize: 48,
          fontWeight: FontWeight.w400,
          height: 1.15,
        ),
        headlineMedium: _notoSans(
          fontSize: 34,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          height: 1.29,
        ),
        headlineSmall: _notoSans(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          height: 1.33,
        ),
        titleLarge: _notoSans(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          height: 1.4,
        ),
        titleMedium: _notoSans(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15,
          height: 1.5,
        ),
        titleSmall: _notoSans(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          height: 1.43,
        ),
        bodyLarge: _notoSans(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          height: 1.5,
        ),
        bodyMedium: _notoSans(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          height: 1.43,
        ),
        labelLarge: _notoSans(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
          height: 1.43,
        ),
        bodySmall: _notoSans(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          height: 1.33,
        ),
        labelSmall: _notoSans(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.5,
          height: 1.2,
        ),
      );

  static TextStyle _notoSans({
    required double fontSize,
    required FontWeight fontWeight,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.notoSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  // Commonly used text styles
  static TextStyle get muTitle => textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.bold,
      );

  static TextStyle get postTitle => textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w600,
      );

  static TextStyle get postContent => textTheme.bodyMedium!;

  static TextStyle get commentText => textTheme.bodyMedium!;

  static TextStyle get metadata => textTheme.bodySmall!.copyWith(
        color: const Color(0xFF666666),
      );
}
