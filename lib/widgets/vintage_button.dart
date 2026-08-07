import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// A vintage "stamp / ticket" button.
///
/// Square corners with a solid offset shadow that reads like an inked stamp.
/// On press the button shifts into its own shadow (tactile depress) rather
/// than lifting (DESIGN.md → Buttons / Interaction Depth).
class VintageButton extends StatefulWidget {
  const VintageButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.background = AppColors.primary,
    this.foreground = AppColors.onPrimary,
    this.shadowColor = AppColors.primary,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
  });

  final String label;
  final VoidCallback onPressed;
  final Color background;
  final Color foreground;
  final Color shadowColor;
  final EdgeInsets padding;

  @override
  State<VintageButton> createState() => _VintageButtonState();
}

class _VintageButtonState extends State<VintageButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    const offset = 3.0;
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 90),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(
          _pressed ? offset : 0,
          _pressed ? offset : 0,
          0,
        ),
        decoration: BoxDecoration(
          color: widget.background,
          border: Border.all(color: widget.shadowColor),
          boxShadow: _pressed
              ? const []
              : [
                  BoxShadow(
                    color: widget.shadowColor,
                    offset: const Offset(offset, offset),
                  ),
                ],
        ),
        padding: widget.padding,
        child: Text(
          widget.label.toUpperCase(),
          style: AppText.labelSm.copyWith(
            color: widget.foreground,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}
