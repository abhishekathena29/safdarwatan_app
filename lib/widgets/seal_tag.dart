import 'package:flutter/material.dart';

import '../theme/app_text_styles.dart';

/// A small "wax seal / fabric tag" label used for categories and metadata
/// (DESIGN.md → Chips & Tags). Low-opacity background, high-contrast text.
class SealTag extends StatelessWidget {
  const SealTag({
    super.key,
    required this.label,
    required this.color,
    this.background,
    this.rounded = false,
    this.bordered = false,
  });

  final String label;
  final Color color;
  final Color? background;
  final bool rounded;
  final bool bordered;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: background ?? color.withValues(alpha: 0.1),
        borderRadius: rounded ? BorderRadius.circular(999) : BorderRadius.zero,
        border: bordered
            ? Border.all(color: color.withValues(alpha: 0.2))
            : null,
      ),
      child: Text(
        label.toUpperCase(),
        style: AppText.labelSm.copyWith(color: color),
      ),
    );
  }
}
