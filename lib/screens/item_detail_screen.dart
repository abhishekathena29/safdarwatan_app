import 'package:flutter/material.dart';

import '../data/archive_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/archive_image.dart';
import '../widgets/grain_overlay.dart';
import '../widgets/seal_tag.dart';
import '../widgets/vintage_button.dart';

/// Detail view for a single [ArchiveItem] — the catalogue record, presented
/// like a filed plate with its Dublin-Core-style metadata beneath.
class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({super.key, required this.item});

  final ArchiveItem item;

  Collection? get _collection {
    if (item.collectionId == null) return null;
    for (final c in kCollections) {
      if (c.id == item.collectionId) return c;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final collection = _collection;
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
                // Plate.
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    border: Border.all(
                      color: AppColors.outline.withValues(alpha: 0.3),
                    ),
                  ),
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: ArchiveImage(
                      icon: item.kind.icon,
                      caption: item.caption,
                    ),
                  ),
                ),
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
                const SizedBox(height: 32),
                _metadata(collection),
                const SizedBox(height: 32),
                if (item.tags.isNotEmpty) ...[
                  Text(
                    'TAGS',
                    style: AppText.labelSm.copyWith(
                      color: AppColors.onSurfaceVariant.withValues(alpha: 0.7),
                      letterSpacing: 2,
                    ),
                  ),
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

  Widget _metadata(Collection? collection) {
    final rows = <(String, String)>[
      ('Catalog No.', '${item.catalogNo}'),
      ('Type', item.kind.label),
      ('Creator', item.creator),
      if (item.duration != null) ('Duration', item.duration!),
      if (collection != null) ('Collection', collection.title),
    ];
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        children: [
          for (int i = 0; i < rows.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                      style: AppText.bodyMd.copyWith(color: AppColors.onSurface),
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
