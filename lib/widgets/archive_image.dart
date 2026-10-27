import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Shown wherever an item has no photograph of its own (for now).
const _defaultAsset = 'assets/images/site_banner.jpg';

/// The banner's paper colour, so the letterboxed banner blends into its slot.
const _defaultBackground = Color(0xFFF5EBEA);

/// An archival photograph.
///
/// Renders the bundled [asset] (a photo or video still from the site) with a
/// light vignette. When an item has no image, the Safar Dar Watan banner is
/// shown whole on its own paper colour; the sepia icon stand-in remains only
/// as a fallback if an image fails to load.
class ArchiveImage extends StatelessWidget {
  const ArchiveImage({
    super.key,
    required this.icon,
    this.caption,
    this.aspectRatio,
    this.asset,
    this.fit = BoxFit.cover,
  });

  final IconData icon;
  final String? caption;
  final double? aspectRatio;
  final String? asset;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final content = asset != null ? _photo() : _defaultImage();
    if (aspectRatio != null) {
      return AspectRatio(aspectRatio: aspectRatio!, child: content);
    }
    return content;
  }

  Widget _defaultImage() {
    return ColoredBox(
      color: _defaultBackground,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          _defaultAsset,
          fit: BoxFit.contain,
          errorBuilder: (_, _, _) => _placeholder(),
        ),
      ),
    );
  }

  Widget _photo() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          asset!,
          fit: fit,
          errorBuilder: (_, _, _) => _placeholder(),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              radius: 1.1,
              colors: [
                Colors.transparent,
                AppColors.onSurface.withValues(alpha: 0.18),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _placeholder() {
    return DecoratedBox(
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
  }
}
