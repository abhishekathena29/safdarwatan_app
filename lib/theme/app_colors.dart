import 'package:flutter/material.dart';

/// Color tokens from the "Digital Heirloom" design system (DESIGN.md).
///
/// The palette is rooted in the natural and architectural landscape of
/// Kashmir: terracotta primary, saffron-ochre secondary, deep emerald
/// tertiary, and a warm "aged paper" neutral base.
class AppColors {
  AppColors._();

  // Surfaces / neutrals (aged paper).
  static const Color surface = Color(0xFFFCF9F2);
  static const Color surfaceDim = Color(0xFFDCDAD3);
  static const Color surfaceBright = Color(0xFFFCF9F2);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF6F3EC);
  static const Color surfaceContainer = Color(0xFFF1EEE7);
  static const Color surfaceContainerHigh = Color(0xFFEBE8E1);
  static const Color surfaceContainerHighest = Color(0xFFE5E2DB);
  static const Color surfaceVariant = Color(0xFFE5E2DB);

  // Text / on-surface (charcoal, softer than pure black).
  static const Color onSurface = Color(0xFF1C1C18);
  static const Color onSurfaceVariant = Color(0xFF56423E);
  static const Color inverseSurface = Color(0xFF31312C);
  static const Color inverseOnSurface = Color(0xFFF3F0E9);

  // Outlines.
  static const Color outline = Color(0xFF89726D);
  static const Color outlineVariant = Color(0xFFDCC0BA);
  static const Color surfaceTint = Color(0xFF9D422C);

  // Primary — terracotta.
  static const Color primary = Color(0xFF6D200D);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF8C3621);
  static const Color onPrimaryContainer = Color(0xFFFFB29F);
  static const Color inversePrimary = Color(0xFFFFB4A2);

  // Secondary — saffron ochre.
  static const Color secondary = Color(0xFF7F5700);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFFEBE50);
  static const Color onSecondaryContainer = Color(0xFF724D00);

  // Tertiary — deep emerald.
  static const Color tertiary = Color(0xFF194231);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFF325947);
  static const Color onTertiaryContainer = Color(0xFFA3CEB7);

  // Error.
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  // Fixed pairs used across cards.
  static const Color primaryFixed = Color(0xFFFFDAD2);
  static const Color primaryFixedDim = Color(0xFFFFB4A2);
  static const Color onPrimaryFixed = Color(0xFF3C0700);
  static const Color onPrimaryFixedVariant = Color(0xFF7E2C17);
  static const Color secondaryFixed = Color(0xFFFFDEAD);
  static const Color secondaryFixedDim = Color(0xFFFBBB4D);
  static const Color onSecondaryFixed = Color(0xFF281900);
  static const Color onSecondaryFixedVariant = Color(0xFF604100);
  static const Color tertiaryFixed = Color(0xFFC1ECD4);
  static const Color tertiaryFixedDim = Color(0xFFA5D0B9);
  static const Color onTertiaryFixed = Color(0xFF002114);
  static const Color onTertiaryFixedVariant = Color(0xFF274E3D);

  static const Color background = Color(0xFFFCF9F2);
  static const Color onBackground = Color(0xFF1C1C18);

  // Accent used by the Poetry collection card ("Deep Blue").
  static const Color poetryBlue = Color(0xFF001F3F);
}
