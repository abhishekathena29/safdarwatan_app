import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/archive_image.dart';
import '../widgets/seal_tag.dart';
import '../widgets/vintage_button.dart';

/// Browse Collections — the heritage-category bento grid.
class CollectionsScreen extends StatelessWidget {
  const CollectionsScreen({super.key});

  static const _margin = 20.0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(_margin, 16, _margin, 120),
      children: [
        _buildHeader(),
        const SizedBox(height: 24),
        _poetryCard(),
        const SizedBox(height: 24),
        _cuisineCard(),
        const SizedBox(height: 24),
        _communityCard(),
        const SizedBox(height: 24),
        _artsCard(),
        const SizedBox(height: 24),
        _architectureCard(),
        const SizedBox(height: 24),
        _oralHistoryCard(),
        const SizedBox(height: 40),
        Center(
          child: VintageButton(
            label: 'Contribute to the Archive',
            onPressed: () {},
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            '7 Collections Found in the Repository',
            style: AppText.bodyMd.copyWith(fontStyle: FontStyle.italic),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'EXPLORE THE ARCHIVE',
          style: AppText.labelSm.copyWith(
            color: AppColors.primary,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Browse Collections',
          style: AppText.displayLg.copyWith(
            color: AppColors.onSurfaceVariant,
            fontSize: 40,
          ),
        ),
        const SizedBox(height: 8),
        Container(height: 4, width: 96, color: AppColors.primary),
      ],
    );
  }

  /// Shared chrome: a card with the asymmetric hairline border.
  Widget _card({required Widget child, Color? color}) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? AppColors.surfaceContainer,
        border: Border.all(
          color: AppColors.onSurfaceVariant.withValues(alpha: 0.3),
          width: 0.5,
        ),
      ),
      child: child,
    );
  }

  // ── Poetry (deep blue) ──────────────────────────────────────────────────
  Widget _poetryCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SealTag(
                  label: 'Collection 07',
                  color: AppColors.poetryBlue,
                ),
                const SizedBox(height: 16),
                Text(
                  'شاعری (shayari)',
                  style: AppText.headlineLg.copyWith(color: AppColors.poetryBlue),
                ),
                const SizedBox(height: 8),
                Text(
                  'Poetry of the Valley',
                  style: AppText.titleMd.copyWith(
                    fontStyle: FontStyle.italic,
                    color: AppColors.onSurfaceVariant.withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'A curated selection of Kashmiri verse, from the mystical '
                  'Vakhs of Lal Ded to contemporary resistance literature.',
                  style: AppText.bodyMd,
                ),
                const SizedBox(height: 24),
                _viewArchiveLink(),
              ],
            ),
          ),
          const SizedBox(
            height: 160,
            child: ArchiveImage(icon: Icons.menu_book, caption: 'Calligraphy'),
          ),
        ],
      ),
    );
  }

  // ── Cuisine (saffron) ───────────────────────────────────────────────────
  Widget _cuisineCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.secondaryContainer.withValues(alpha: 0.2),
              border: const Border(
                bottom: BorderSide(color: AppColors.outlineVariant),
              ),
            ),
            child: Text(
              'WAZWAN & HEARTH',
              style: AppText.labelSm.copyWith(
                color: AppColors.secondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'کھیوٚن (khyawun)',
                  style: AppText.headlineLg.copyWith(color: AppColors.secondary),
                ),
                const SizedBox(height: 8),
                Text(
                  'Traditional Cuisine',
                  style: AppText.titleMd.copyWith(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              const SizedBox(
                height: 160,
                child: ArchiveImage(icon: Icons.soup_kitchen, caption: 'Rogan Josh'),
              ),
              Positioned(
                right: 16,
                bottom: 16,
                child: VintageButton(
                  label: 'Open',
                  onPressed: () {},
                  background: AppColors.secondary,
                  foreground: AppColors.onSecondary,
                  shadowColor: AppColors.secondary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Community (resilience) ───────────────────────────────────────────────
  Widget _communityCard() {
    return _card(
      color: AppColors.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Advocacy & Memory',
              style: AppText.labelSm
                  .copyWith(color: AppColors.onPrimaryFixedVariant),
            ),
            const SizedBox(height: 16),
            Text(
              'وپکار (wupkar)',
              style: AppText.headlineLg.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            Text(
              'Community Outreach',
              style: AppText.titleMd.copyWith(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.05),
                border: const Border(
                  left: BorderSide(color: AppColors.primary, width: 4),
                ),
              ),
              child: Text(
                '"Elevating voices that echo through the chinar trees, bridging '
                'the gap between exile and identity."',
                style: AppText.bodyMd.copyWith(fontStyle: FontStyle.italic),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'EXPLORE GLOBAL AWARENESS',
                  style: AppText.labelSm.copyWith(color: AppColors.primary),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.north_east, size: 16, color: AppColors.primary),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── Arts & Crafts (emerald) ──────────────────────────────────────────────
  Widget _artsCard() {
    return _card(
      color: const Color(0xFFE0EFEA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ARTISANSHIP',
                  style: AppText.labelSm.copyWith(color: AppColors.tertiary),
                ),
                const SizedBox(height: 16),
                Text(
                  'کاریگَری (kārigāri)',
                  style: AppText.headlineLg.copyWith(color: AppColors.tertiary),
                ),
                const SizedBox(height: 8),
                Text(
                  'Traditional Arts',
                  style: AppText.titleMd.copyWith(
                    fontStyle: FontStyle.italic,
                    color: AppColors.onTertiaryFixedVariant,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Papier-mâché, Pashmina weaving, and walnut wood carving. '
                  'The hands of the masters preserved in pixels.',
                  style: AppText.bodyMd
                      .copyWith(color: AppColors.onTertiaryFixedVariant),
                ),
                const SizedBox(height: 24),
                Row(
                  children: const [
                    SealTag(
                      label: 'Textile',
                      color: AppColors.tertiary,
                      rounded: true,
                      bordered: true,
                    ),
                    SizedBox(width: 8),
                    SealTag(
                      label: 'Woodcraft',
                      color: AppColors.tertiary,
                      rounded: true,
                      bordered: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 160,
            child: ArchiveImage(icon: Icons.handyman, caption: 'Walnut Carving'),
          ),
        ],
      ),
    );
  }

  // ── Architectural Epigraphy (slate) ──────────────────────────────────────
  Widget _architectureCard() {
    return _card(
      color: AppColors.surfaceVariant,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Stack(
          children: [
            Positioned(
              right: -10,
              top: -10,
              child: Icon(
                Icons.architecture,
                size: 120,
                color: AppColors.onSurface.withValues(alpha: 0.06),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ARCHITECTURAL HISTORY',
                  style: AppText.labelSm,
                ),
                const SizedBox(height: 16),
                Text('Naqsh... The Imprint', style: AppText.headlineLg),
                const SizedBox(height: 8),
                Text(
                  'Architectural Epigraphy',
                  style: AppText.titleMd.copyWith(
                    color: AppColors.primary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Tracing the Sultanate, Afghan, and Sikh inscriptions on the '
                  'stones of the valley. A study in stone and soul.',
                  style: AppText.bodyMd,
                ),
                const SizedBox(height: 24),
                VintageButton(
                  label: 'Browse Exhibit',
                  onPressed: () {},
                  background: AppColors.onSurface,
                  foreground: AppColors.surface,
                  shadowColor: AppColors.onSurface,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── Oral History (warm paper) ────────────────────────────────────────────
  Widget _oralHistoryCard() {
    return _card(
      color: AppColors.primaryFixed,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LIVING MEMORY',
                      style: AppText.labelSm
                          .copyWith(color: AppColors.onPrimaryFixedVariant),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Oral History',
                      style: AppText.headlineLg
                          .copyWith(color: AppColors.onPrimaryFixedVariant),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Podcast & Narratives',
                      style: AppText.titleMd.copyWith(
                        color: AppColors.onPrimaryFixedVariant
                            .withValues(alpha: 0.7),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _episode('Episode 14: The Lost Ladishah'),
                    const SizedBox(height: 8),
                    _episode('Episode 15: Migration Memories'),
                  ],
                ),
              ),
            ),
            Container(
              width: 48,
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(color: AppColors.onPrimaryFixedVariant),
                ),
              ),
              child: Center(
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Text(
                    'LISTEN • RECORD • REMEMBER',
                    style: AppText.labelSm.copyWith(
                      color: AppColors.onPrimaryFixedVariant
                          .withValues(alpha: 0.4),
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _episode(String title) {
    return Row(
      children: [
        const Icon(Icons.mic, size: 18, color: AppColors.onPrimaryFixedVariant),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: AppText.bodyMd.copyWith(color: AppColors.onPrimaryFixedVariant),
          ),
        ),
      ],
    );
  }

  Widget _viewArchiveLink() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'VIEW ARCHIVE',
          style: AppText.labelSm.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
            decoration: TextDecoration.underline,
          ),
        ),
        const SizedBox(width: 8),
        const Icon(Icons.arrow_forward, size: 16, color: AppColors.primary),
      ],
    );
  }
}
