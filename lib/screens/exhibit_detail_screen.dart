import 'package:flutter/material.dart';

import '../data/archive_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/archive_image.dart';
import '../widgets/grain_overlay.dart';
import '../widgets/vintage_button.dart';

/// Immersive detail view for a thematic [Exhibit] — the curated narrative
/// followed by a gallery of catalogued plates (thematic_exhibits.html).
class ExhibitDetailScreen extends StatelessWidget {
  const ExhibitDetailScreen({super.key, required this.exhibit});

  final Exhibit exhibit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          'THEMATIC EXHIBIT',
          style: AppText.labelSm.copyWith(
            color: AppColors.secondary,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        shape: const Border(
          bottom: BorderSide(color: AppColors.outlineVariant),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 48),
              children: [
                _buildHero(context),
                const SizedBox(height: 24),
                Container(height: 0.5, color: AppColors.outlineVariant),
                const SizedBox(height: 32),
                _buildNarrative(),
                const SizedBox(height: 24),
                _buildPullQuote(),
                const SizedBox(height: 24),
                _buildTags(),
                const SizedBox(height: 40),
                _buildGalleryHeader(),
                const SizedBox(height: 16),
                for (final art in exhibit.artifacts) ...[
                  _ArtifactCard(artifact: art),
                  const SizedBox(height: 16),
                ],
                const SizedBox(height: 16),
                _buildExhibitNav(context),
              ],
            ),
          ),
          const Positioned.fill(child: GrainOverlay()),
        ],
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'THEMATIC EXHIBIT',
          style: AppText.labelSm.copyWith(
            color: AppColors.secondary,
            letterSpacing: 2,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          exhibit.title,
          style: AppText.displayLg.copyWith(fontSize: 40),
        ),
        const SizedBox(height: 12),
        Text(
          exhibit.subtitle,
          style: AppText.titleMd.copyWith(
            color: AppColors.onSurfaceVariant,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 20),
        VintageButton(
          label: 'Enter Gallery',
          onPressed: () {},
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
        ),
      ],
    );
  }

  Widget _buildNarrative() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Drop-cap lead paragraph.
        RichText(
          text: TextSpan(
            style: AppText.bodyLg.copyWith(color: AppColors.onSurface),
            children: [
              TextSpan(
                text: exhibit.summary.substring(0, 1),
                style: AppText.headlineLg.copyWith(
                  color: AppColors.primary,
                  height: 1,
                ),
              ),
              TextSpan(text: exhibit.summary.substring(1)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(exhibit.body, style: AppText.bodyMd),
      ],
    );
  }

  Widget _buildPullQuote() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLow,
        border: Border(
          left: BorderSide(color: AppColors.primary, width: 4),
        ),
      ),
      child: Text(
        '"${exhibit.pullQuote}"',
        style: AppText.bodyMd.copyWith(
          fontStyle: FontStyle.italic,
          color: AppColors.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildTags() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final tag in exhibit.tags)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.tertiaryFixed,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              tag.toUpperCase(),
              style: AppText.labelSm.copyWith(
                color: AppColors.onTertiaryFixedVariant,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildGalleryHeader() {
    return Row(
      children: [
        Text(
          'GALLERY',
          style: AppText.labelSm.copyWith(
            color: AppColors.primary,
            letterSpacing: 2,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(height: 1, color: AppColors.outlineVariant),
        ),
        const SizedBox(width: 12),
        Text(
          '${exhibit.artifacts.length} plates',
          style: AppText.labelSm.copyWith(
            color: AppColors.onSurfaceVariant.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildExhibitNav(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.outlineVariant)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _navLink(Icons.arrow_back, 'Previous', () {}),
          _navLink(Icons.arrow_forward, 'Explore More', () {
            Navigator.of(context).maybePop();
          }, trailing: true),
        ],
      ),
    );
  }

  Widget _navLink(IconData icon, String label, VoidCallback onTap,
      {bool trailing = false}) {
    final children = <Widget>[
      Icon(icon, size: 18, color: AppColors.onSurfaceVariant),
      const SizedBox(width: 8),
      Text(
        label.toUpperCase(),
        style: AppText.labelSm.copyWith(color: AppColors.onSurfaceVariant),
      ),
    ];
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: trailing ? children.reversed.toList() : children,
      ),
    );
  }
}

/// A single exhibit plate: a header strip with catalog number, the plate, and
/// a caption block. The featured artifact gets a bookmark seal.
class _ArtifactCard extends StatelessWidget {
  const _ArtifactCard({required this.artifact});

  final ExhibitArtifact artifact;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.outline.withValues(alpha: 0.4)),
        boxShadow: const [
          BoxShadow(color: AppColors.primary, offset: Offset(4, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.outlineVariant),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  artifact.catalogNo.toUpperCase(),
                  style: AppText.labelSm.copyWith(
                    color: AppColors.onSurfaceVariant.withValues(alpha: 0.7),
                  ),
                ),
                if (artifact.featured)
                  const Icon(Icons.bookmark,
                      size: 16, color: AppColors.primary),
              ],
            ),
          ),
          AspectRatio(
            aspectRatio: artifact.featured ? 16 / 10 : 4 / 3,
            child: ArchiveImage(icon: artifact.icon),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  artifact.title,
                  style: AppText.titleMd.copyWith(color: AppColors.primary),
                ),
                const SizedBox(height: 4),
                Text(
                  artifact.note,
                  style: AppText.bodyMd.copyWith(
                    fontStyle: FontStyle.italic,
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
