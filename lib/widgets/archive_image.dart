import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Placeholder for an archival photograph.
///
/// The reference design pulls images from a remote CDN; to keep the app
/// self-contained and offline-friendly we render a faded, sepia-toned
/// stand-in with a representative icon and a short caption — echoing the
/// "physical printed photograph" treatment from DESIGN.md (Images).
class ArchiveImage extends StatelessWidget {
  const ArchiveImage({
    super.key,
    required this.icon,
    this.caption,
    this.aspectRatio,
  });

  final IconData icon;
  final String? caption;
  final double? aspectRatio;

  @override
  Widget build(BuildContext context) {
    final content = DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.surfaceContainerHighest,
            AppColors.surfaceDim,
          ],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Icon(
              icon,
              size: 56,
              color: AppColors.onSurfaceVariant.withValues(alpha: 0.35),
            ),
          ),
          // Subtle inner vignette to feel like a printed photo.
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                radius: 0.9,
                colors: [
                  Colors.transparent,
                  AppColors.onSurface.withValues(alpha: 0.12),
                ],
              ),
            ),
          ),
          if (caption != null)
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  caption!.toUpperCase(),
                  style: AppText.labelSm.copyWith(
                    color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ),
        ],
      ),
    );

    if (aspectRatio != null) {
      return AspectRatio(aspectRatio: aspectRatio!, child: content);
    }
    return content;
  }
}
