import 'package:flutter/material.dart';

import '../data/archive_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/archive_image.dart';
import '../widgets/grain_overlay.dart';
import '../widgets/link_opener.dart';
import '../widgets/vintage_button.dart';
import 'item_detail_screen.dart';

/// Immersive detail view for a thematic [Exhibit] — the curated narrative
/// followed by a gallery of catalogued plates (thematic_exhibits.html).
class ExhibitDetailScreen extends StatefulWidget {
  const ExhibitDetailScreen({super.key, required this.exhibit});

  final Exhibit exhibit;

  @override
  State<ExhibitDetailScreen> createState() => _ExhibitDetailScreenState();
}

class _ExhibitDetailScreenState extends State<ExhibitDetailScreen> {
  final _galleryKey = GlobalKey();
  final _scroll = ScrollController();

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  Exhibit get exhibit => widget.exhibit;

  void _enterGallery() {
    final ctx = _galleryKey.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

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
              controller: _scroll,
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
                const SizedBox(height: 24),
                _buildCredits(),
                const SizedBox(height: 40),
                _buildGalleryHeader(),
                const SizedBox(height: 16),
                if (exhibit.film != null) ...[
                  _buildFilm(context),
                  const SizedBox(height: 16),
                ],
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
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: ArchiveImage(
            icon: Icons.account_balance,
            asset: exhibit.cover,
            aspectRatio: 4 / 3,
          ),
        ),
        const SizedBox(height: 24),
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
          onPressed: _enterGallery,
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

  Widget _buildCredits() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CREDITS',
          style: AppText.labelSm.copyWith(
            color: AppColors.onSurfaceVariant.withValues(alpha: 0.7),
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          exhibit.credits,
          style: AppText.bodyMd.copyWith(fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  /// The exhibit's opening film, shown as a still that plays on YouTube.
  Widget _buildFilm(BuildContext context) {
    final film = itemById(exhibit.film!);
    if (film == null) return const SizedBox.shrink();
    final link = film.links.isEmpty ? null : film.links.first;
    return GestureDetector(
      onTap: () => link != null
          ? openLink(context, link.url)
          : Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => ItemDetailScreen(item: film)),
            ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.outline.withValues(alpha: 0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ArchiveImage(
                  icon: Icons.smart_display,
                  asset: film.image,
                  aspectRatio: 16 / 9,
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.play_arrow,
                      size: 32, color: AppColors.onPrimary),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FILM · ITEM #${film.catalogNo}',
                    style: AppText.labelSm.copyWith(color: AppColors.secondary),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    film.title,
                    style: AppText.titleMd.copyWith(color: AppColors.primary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGalleryHeader() {
    return Row(
      key: _galleryKey,
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
          _navLink(Icons.arrow_upward, 'Back to Top', () {
            _scroll.animateTo(
              0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }),
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
    return GestureDetector(
      onTap: () {
        final item = itemById(artifact.itemId);
        if (item == null) return;
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => ItemDetailScreen(item: item)),
        );
      },
      child: _buildCard(),
    );
  }

  Widget _buildCard() {
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
            child: ArchiveImage(icon: artifact.icon, asset: artifact.image),
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
