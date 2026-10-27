import 'package:flutter/material.dart';

import '../data/archive_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/archive_image.dart';
import '../widgets/grain_overlay.dart';
import '../widgets/link_opener.dart';
import '../widgets/seal_tag.dart';
import '../widgets/vintage_button.dart';
import 'browse_items_screen.dart';
import 'map_screen.dart';

/// Detail view for a single [ArchiveItem] — the catalogue record, presented
/// like a filed plate with its Dublin-Core-style metadata beneath.
class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({super.key, required this.item});

  final ArchiveItem item;

  @override
  Widget build(BuildContext context) {
    final collection = collectionById(item.collectionId);
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
          'Item #${item.catalogNo}',
          style: AppText.labelSm.copyWith(
            color: AppColors.onSurfaceVariant,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'View on the website',
            icon: const Icon(Icons.public, color: AppColors.primary),
            onPressed: () => openLink(context, item.siteUrl),
          ),
        ],
        shape: const Border(
          bottom: BorderSide(color: AppColors.outlineVariant),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 48),
              children: [
                _buildPlate(context),
                const SizedBox(height: 24),
                SealTag(
                  label: item.kind.label,
                  color: AppColors.onPrimaryFixedVariant,
                ),
                const SizedBox(height: 16),
                Text(item.title, style: AppText.headlineLgMobile),
                if (item.subtitle != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    item.subtitle!,
                    style: AppText.titleMd.copyWith(
                      fontStyle: FontStyle.italic,
                      color: AppColors.onSurfaceVariant.withValues(alpha: 0.85),
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                if (item.description != null)
                  Text(item.description!, style: AppText.bodyLg),
                if (item.links.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  for (final link in item.links) ...[
                    MediaLinkTile(link: link),
                    const SizedBox(height: 8),
                  ],
                ],
                const SizedBox(height: 32),
                _metadata(context, collection),
                if (item.outline.isNotEmpty) ...[
                  const SizedBox(height: 32),
                  _buildOutline(),
                ],
                if (item.geo != null) ...[
                  const SizedBox(height: 32),
                  _buildLocation(context),
                ],
                const SizedBox(height: 32),
                if (item.tags.isNotEmpty) ...[
                  _label('Tags'),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final t in item.tags)
                        SealTag(
                          label: t,
                          color: AppColors.secondary,
                          rounded: true,
                          bordered: true,
                        ),
                    ],
                  ),
                  const SizedBox(height: 32),
                ],
                Center(
                  child: VintageButton(
                    label: 'Back to Archive',
                    onPressed: () => Navigator.of(context).maybePop(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 14),
                  ),
                ),
              ],
            ),
          ),
          const Positioned.fill(child: GrainOverlay()),
        ],
      ),
    );
  }

  Widget _buildPlate(BuildContext context) {
    final plate = Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(
          color: AppColors.outline.withValues(alpha: 0.3),
        ),
      ),
      child: Stack(
        children: [
          ArchiveImage(
            icon: item.kind.icon,
            caption: item.caption,
            asset: item.image,
            aspectRatio: 4 / 3,
          ),
          if (item.image != null)
            Positioned(
              right: 8,
              bottom: 8,
              child: Container(
                padding: const EdgeInsets.all(6),
                color: AppColors.surface.withValues(alpha: 0.85),
                child: const Icon(Icons.zoom_out_map,
                    size: 18, color: AppColors.primary),
              ),
            ),
        ],
      ),
    );
    if (item.image == null) return plate;
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => PhotoViewerScreen(asset: item.image!, title: item.title),
        ),
      ),
      child: plate,
    );
  }

  Widget _label(String text) => Text(
        text.toUpperCase(),
        style: AppText.labelSm.copyWith(
          color: AppColors.onSurfaceVariant.withValues(alpha: 0.7),
          letterSpacing: 2,
        ),
      );

  Widget _buildOutline() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label('Episode Outline'),
        const SizedBox(height: 12),
        for (final e in item.outline)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 64,
                  child: Text(
                    e.time,
                    style: AppText.labelSm.copyWith(
                      color: AppColors.primary,
                      height: 1.6,
                    ),
                  ),
                ),
                Expanded(child: Text(e.title, style: AppText.bodyMd)),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildLocation(BuildContext context) {
    final geo = item.geo!;
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: AppColors.background,
              surfaceTintColor: Colors.transparent,
              iconTheme: const IconThemeData(color: AppColors.primary),
              title: Text(
                geo.place.toUpperCase(),
                style: AppText.labelSm.copyWith(letterSpacing: 2),
              ),
              centerTitle: true,
            ),
            body: MapScreen(focusItemId: item.catalogNo),
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.tertiaryFixed.withValues(alpha: 0.4),
          border: Border.all(color: AppColors.outlineVariant),
        ),
        child: Row(
          children: [
            const Icon(Icons.place, color: AppColors.tertiary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    geo.place,
                    style: AppText.bodyMd.copyWith(
                      color: AppColors.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${geo.lat.toStringAsFixed(4)}, '
                    '${geo.lng.toStringAsFixed(4)}',
                    style: AppText.labelSm,
                  ),
                ],
              ),
            ),
            Text(
              'VIEW ON MAP',
              style: AppText.labelSm.copyWith(
                color: AppColors.tertiary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _metadata(BuildContext context, Collection? collection) {
    final rows = <(String, String, VoidCallback?)>[
      ('Catalog No.', '${item.catalogNo}', null),
      ('Type', item.kind.label, null),
      ('Creator', item.creator, null),
      if (item.date != null) ('Date', item.date!, null),
      if (item.duration != null) ('Duration', item.duration!, null),
      if (item.interviewer != null) ('Interviewer', item.interviewer!, null),
      if (item.interviewee != null) ('Interviewee', item.interviewee!, null),
      if (item.contributors != null) ('Contributors', item.contributors!, null),
      if (item.recordedAt != null) ('Recorded', item.recordedAt!, null),
      if (item.language != null) ('Language', item.language!, null),
      if (item.publisher != null) ('Publisher', item.publisher!, null),
      if (collection != null)
        (
          'Collection',
          collection.title,
          () => BrowseItemsScreen.openCollection(context, collection),
        ),
    ];
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        children: [
          for (int i = 0; i < rows.length; i++)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: rows[i].$3,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: i == rows.length - 1
                      ? null
                      : const Border(
                          bottom: BorderSide(color: AppColors.outlineVariant),
                        ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 110,
                      child: Text(
                        rows[i].$1.toUpperCase(),
                        style: AppText.labelSm.copyWith(
                          color:
                              AppColors.onSurfaceVariant.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        rows[i].$2,
                        style: AppText.bodyMd.copyWith(
                          color: rows[i].$3 != null
                              ? AppColors.primary
                              : AppColors.onSurface,
                          decoration: rows[i].$3 != null
                              ? TextDecoration.underline
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Full-screen, pinch-to-zoom view of an archival photograph.
class PhotoViewerScreen extends StatelessWidget {
  const PhotoViewerScreen({super.key, required this.asset, this.title});

  final String asset;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.inverseSurface,
      appBar: AppBar(
        backgroundColor: AppColors.inverseSurface,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.inverseOnSurface),
        title: title == null
            ? null
            : Text(
                title!,
                style: AppText.labelSm
                    .copyWith(color: AppColors.inverseOnSurface),
              ),
      ),
      body: InteractiveViewer(
        maxScale: 5,
        child: Center(child: Image.asset(asset)),
      ),
    );
  }
}
