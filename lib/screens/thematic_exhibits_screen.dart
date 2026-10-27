import 'package:flutter/material.dart';

import '../data/archive_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/archive_image.dart';
import '../widgets/seal_tag.dart';
import 'exhibit_detail_screen.dart';

/// Thematic Exhibits — curated narratives drawn from the archive. Presents a
/// featured exhibit card per exhibit; tapping opens the immersive detail.
class ThematicExhibitsScreen extends StatelessWidget {
  const ThematicExhibitsScreen({super.key});

  static const _margin = 20.0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(_margin, 16, _margin, 120),
      children: [
        _buildHeader(),
        const SizedBox(height: 24),
        for (final exhibit in kExhibits) ...[
          _ExhibitCard(exhibit: exhibit),
          const SizedBox(height: 24),
        ],
        _buildUpcoming(),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CURATED NARRATIVES',
          style: AppText.labelSm.copyWith(
            color: AppColors.secondary,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Thematic Exhibits',
          style: AppText.displayLg.copyWith(
            color: AppColors.onSurfaceVariant,
            fontSize: 40,
          ),
        ),
        const SizedBox(height: 8),
        Container(height: 4, width: 96, color: AppColors.secondary),
        const SizedBox(height: 16),
        Text(
          'Stories assembled from the archive — each a journey through a single '
          'thread of Kashmiri heritage.',
          style: AppText.bodyLg,
        ),
      ],
    );
  }

  Widget _buildUpcoming() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.outlineVariant,
        ),
        color: AppColors.surfaceContainerLow,
      ),
      child: Column(
        children: [
          Icon(Icons.museum,
              size: 40, color: AppColors.outline.withValues(alpha: 0.5)),
          const SizedBox(height: 12),
          Text(
            'More exhibits in curation',
            style: AppText.titleMd.copyWith(color: AppColors.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'New thematic journeys are added as the archive grows.',
            style: AppText.bodyMd.copyWith(fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// A featured exhibit card with a banner plate and a curated summary.
class _ExhibitCard extends StatelessWidget {
  const _ExhibitCard({required this.exhibit});

  final Exhibit exhibit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ExhibitDetailScreen(exhibit: exhibit),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.outline.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ArchiveImage(
                    icon: Icons.account_balance,
                    asset: exhibit.cover,
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: SealTag(
                    label: 'Exhibit',
                    color: AppColors.onPrimary,
                    background: AppColors.primary,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(exhibit.title, style: AppText.headlineLgMobile),
                  const SizedBox(height: 8),
                  Text(
                    exhibit.subtitle,
                    style: AppText.bodyMd.copyWith(
                      fontStyle: FontStyle.italic,
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    exhibit.summary,
                    style: AppText.bodyMd,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        '${exhibit.artifacts.length} plates',
                        style: AppText.labelSm.copyWith(
                          color:
                              AppColors.onSurfaceVariant.withValues(alpha: 0.7),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'VIEW EXHIBIT',
                        style: AppText.labelSm.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward,
                          size: 16, color: AppColors.primary),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
