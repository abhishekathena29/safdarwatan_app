import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/archive_image.dart';
import '../widgets/seal_tag.dart';
import '../widgets/vintage_button.dart';

/// Home / About — "A Journey Home".
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.onBrowseCollection});

  final VoidCallback? onBrowseCollection;

  static const _margin = 20.0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(_margin, 24, _margin, 120),
      children: [
        _buildHero(),
        const SizedBox(height: 64),
        _buildAbout(),
        const SizedBox(height: 96),
        _buildCallToTreasure(),
        const SizedBox(height: 96),
        _buildPhilosophy(),
        const SizedBox(height: 64),
        _buildFooter(),
      ],
    );
  }

  // ── Hero ──────────────────────────────────────────────────────────────
  Widget _buildHero() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: const ArchiveImage(
            icon: Icons.landscape,
            aspectRatio: 3.21 / 1,
            caption: 'The Valley',
          ),
        ),
        const SizedBox(height: 40),
        Text(
          'Safar Dar Watan',
          textAlign: TextAlign.center,
          style: AppText.displayLg.copyWith(
            color: AppColors.primary,
            fontSize: 40,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'A JOURNEY HOME',
          style: AppText.labelSm.copyWith(
            letterSpacing: 2.4,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  // ── About ─────────────────────────────────────────────────────────────
  Widget _buildAbout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16),
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
          child: Text(
            'About',
            style: AppText.headlineLgMobile.copyWith(
              color: AppColors.primary,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Pull-quote card — rotated slightly to feel "placed".
        Transform.rotate(
          angle: 0.0175, // ≈ 1°
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              border: Border.all(color: AppColors.outlineVariant),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '"A personal story of longing, resilience, and a strong sense '
              'of duty forms the foundation of Safar Dar Watan: A Journey Home."',
              style: AppText.titleMd.copyWith(
                color: AppColors.onPrimaryFixedVariant,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        Text(
          'After relocating from the tranquil slopes of Kashmir to the vibrant '
          'metropolis of Delhi, Aania felt a profound emptiness—a separation '
          'from the customs and narratives that constituted her identity. Her '
          'sentiment was not unique; it struck a chord with others who were '
          'separated from their homeland and unable to really appreciate its '
          'wisdom and beauty.',
          style: AppText.bodyLg,
        ),
        const SizedBox(height: 16),
        RichText(
          text: TextSpan(
            style: AppText.bodyLg,
            children: [
              const TextSpan(
                text: 'Motivated by this common experience, Aania saw ',
              ),
              TextSpan(
                text: 'Safar Dar Watan',
                style: AppText.bodyLg.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const TextSpan(
                text: ' as a means of rediscovering her roots and assisting '
                    'others in rediscovering their own ties to Kashmir.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Every tale, ritual, and habit here is a step towards coming home, '
          'urging introspection, pride, and rekindling of bonds that are too '
          'important to be lost.',
          style: AppText.bodyLg.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'The platform is a rich trove of folktales that reverberate around '
          'the fire, melodies that carry the whispers of the mountains, and '
          'objects that speak of lives lived and treasured memories.',
          style: AppText.bodyLg,
        ),
      ],
    );
  }

  // ── Call to Treasure (bento grid) ───────────────────────────────────────
  Widget _buildCallToTreasure() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'THE MISSION',
          style: AppText.labelSm.copyWith(
            color: AppColors.primary,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 4),
        Text('Call to Treasure', style: AppText.headlineLgMobile),
        const SizedBox(height: 24),
        _largeMissionCard(),
        const SizedBox(height: 12),
        _podcastCard(),
        const SizedBox(height: 12),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _smallCard(
                  Icons.explore,
                  'Cultural Map',
                  'Geographical roots of folktales.',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _smallCard(
                  Icons.auto_stories,
                  'Shared Resource',
                  'Democratizing legacy.',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _largeMissionCard() {
    return ClipRect(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer,
          border: Border.all(color: AppColors.outlineVariant),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -30,
              bottom: -40,
              child: Icon(
                Icons.history_edu,
                size: 160,
                color: AppColors.onSurface.withValues(alpha: 0.06),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SealTag(
                  label: 'Heritage',
                  color: AppColors.onTertiaryContainer,
                  background: AppColors.tertiaryContainer,
                ),
                const SizedBox(height: 16),
                Text('Digital Archive of Memory', style: AppText.titleMd),
                const SizedBox(height: 8),
                Text(
                  'Aania intends to transform the archive from a collection '
                  'into a call to treasure, recall, and protect the memories '
                  'that define everyone\'s feeling of home.',
                  style: AppText.bodyMd,
                ),
                const SizedBox(height: 40),
                VintageButton(
                  label: 'Browse Collection',
                  onPressed: onBrowseCollection ?? () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _podcastCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.secondaryContainer,
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Community Podcast',
                  style: AppText.titleMd
                      .copyWith(color: AppColors.onSecondaryContainer),
                ),
                const SizedBox(height: 8),
                Text(
                  'Elevating Kashmiri voices and telling tales of happiness, '
                  'adversity, and the importance of preserving home.',
                  style: AppText.bodyMd
                      .copyWith(color: AppColors.onSecondaryFixedVariant),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Listen on Spotify',
                      style: AppText.labelSm.copyWith(
                        color: AppColors.primary,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.dotted,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.open_in_new,
                        size: 14, color: AppColors.primary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          const Icon(Icons.mic, size: 48, color: AppColors.onSecondaryContainer),
        ],
      ),
    );
  }

  Widget _smallCard(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(height: 8),
          Text(
            title.toUpperCase(),
            style: AppText.labelSm.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppText.labelSm.copyWith(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  // ── Philosophy ──────────────────────────────────────────────────────────
  Widget _buildPhilosophy() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.outlineVariant),
          bottom: BorderSide(color: AppColors.outlineVariant),
        ),
      ),
      child: Column(
        children: [
          Text(
            '"It symbolizes a trip back to one\'s roots—both personal and '
            'communal. It goes beyond a simple physical voyage."',
            textAlign: TextAlign.center,
            style: AppText.headlineLgMobile.copyWith(
              color: AppColors.onSurfaceVariant,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _dot(0.2),
              const SizedBox(width: 8),
              _dot(0.4),
              const SizedBox(width: 8),
              _dot(0.2),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dot(double alpha) => Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: alpha),
          shape: BoxShape.circle,
        ),
      );

  // ── Footer ────────────────────────────────────────────────────────────
  Widget _buildFooter() {
    final tags = ['Longing', 'Resilience', 'Heritage', 'Contribute'];
    return Column(
      children: [
        Text(
          'SAFAR DAR WATAN',
          style: AppText.titleMd.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 24,
          runSpacing: 8,
          children: [
            for (final t in tags)
              Text(
                t,
                style: AppText.labelSm.copyWith(fontStyle: FontStyle.italic),
              ),
          ],
        ),
        const SizedBox(height: 16),
        const Icon(Icons.play_circle, color: AppColors.primary),
        const SizedBox(height: 16),
        Text(
          '© 2024 Safar Dar Watan • A Journey Home',
          style: AppText.labelSm.copyWith(
            fontStyle: FontStyle.italic,
            color: AppColors.onSurfaceVariant.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
