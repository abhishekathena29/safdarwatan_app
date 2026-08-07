import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Typography tokens from DESIGN.md.
///
/// - Headlines: Playfair Display (elegant high-contrast serif, heritage feel).
/// - Body: Work Sans (neutral, legible for long archival descriptions).
/// - Labels / metadata: Space Mono (catalogued-archive, typewriter feel).
class AppText {
  AppText._();

  // Display — 48 / 900 / -0.02em.
  static TextStyle displayLg = GoogleFonts.playfairDisplay(
    fontSize: 48,
    fontWeight: FontWeight.w900,
    height: 1.1,
    letterSpacing: -0.96,
    color: AppColors.onSurface,
  );

  // Headline — 32 / 700 (desktop). Mobile variant 28.
  static TextStyle headlineLg = GoogleFonts.playfairDisplay(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.2,
    color: AppColors.onSurface,
  );

  static TextStyle headlineLgMobile = GoogleFonts.playfairDisplay(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.2,
    color: AppColors.onSurface,
  );

  // Title — 22 / 600.
  static TextStyle titleMd = GoogleFonts.playfairDisplay(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: AppColors.onSurface,
  );

  // Body large — 18 / 400.
  static TextStyle bodyLg = GoogleFonts.workSans(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: AppColors.onSurfaceVariant,
  );

  // Body medium — 16 / 400.
  static TextStyle bodyMd = GoogleFonts.workSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: AppColors.onSurfaceVariant,
  );

  // Label small — 12 / 500 / +0.05em (Space Mono).
  static TextStyle labelSm = GoogleFonts.spaceMono(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.0,
    letterSpacing: 0.6,
    color: AppColors.onSurfaceVariant,
  );
}
