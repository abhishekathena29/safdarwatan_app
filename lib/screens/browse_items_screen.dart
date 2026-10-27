import 'package:flutter/material.dart';

import '../data/archive_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/archive_image.dart';
import '../widgets/grain_overlay.dart';
import 'item_detail_screen.dart';

/// Browse Items — the full archive catalogue as a column of "filed" cards,
/// with a search field and a tag filter row (DESIGN.md / browse_items.html).
///
/// Given a [collection], it lists only that collection's items inside its own
/// page (the site's "View the items in …" link).
class BrowseItemsScreen extends StatefulWidget {
  const BrowseItemsScreen({
    super.key,
    this.collection,
    this.autofocusSearch = false,
  });

  final Collection? collection;
  final bool autofocusSearch;

  static const _margin = 20.0;

  static void openCollection(BuildContext context, Collection collection) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BrowseItemsScreen(collection: collection),
      ),
    );
  }

  @override
  State<BrowseItemsScreen> createState() => _BrowseItemsScreenState();
}

class _BrowseItemsScreenState extends State<BrowseItemsScreen> {
  final _searchController = TextEditingController();
  String _query = '';
  String? _activeTag;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ArchiveItem> get _source => widget.collection?.items ?? kItems;

  List<ArchiveItem> get _filtered {
    return _source.where((item) {
      if (_activeTag != null && !item.tags.contains(_activeTag)) return false;
      if (_query.isEmpty) return true;
      final q = _query.toLowerCase();
      return item.title.toLowerCase().contains(q) ||
          (item.subtitle?.toLowerCase().contains(q) ?? false) ||
          (item.description?.toLowerCase().contains(q) ?? false) ||
          (item.contributors?.toLowerCase().contains(q) ?? false) ||
          (item.interviewee?.toLowerCase().contains(q) ?? false) ||
          (item.geo?.place.toLowerCase().contains(q) ?? false) ||
          item.tags.any((t) => t.contains(q));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final list = _buildList();
    if (widget.collection == null) return list;
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
          'COLLECTION',
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
          Positioned.fill(child: list),
          const Positioned.fill(child: GrainOverlay()),
        ],
      ),
    );
  }

  Widget _buildList() {
    final items = _filtered;
    final total = _source.length;
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        BrowseItemsScreen._margin,
        16,
        BrowseItemsScreen._margin,
        120,
      ),
      children: [
        _buildHeader(),
        const SizedBox(height: 24),
        if (total > 0) ...[
          _buildSearch(),
          const SizedBox(height: 24),
          _buildTagFilter(),
          const SizedBox(height: 24),
        ],
        if (items.isEmpty)
          _buildEmpty()
        else
          for (final item in items) ...[
            _ItemCard(item: item),
            const SizedBox(height: 24),
          ],
        const SizedBox(height: 8),
        _buildFooterCount(items.length, total),
      ],
    );
  }

  Widget _buildHeader() {
    final collection = widget.collection;
    if (collection != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            collection.kashmiri,
            style: AppText.headlineLg.copyWith(color: collection.color),
          ),
          const SizedBox(height: 8),
          Text(
            collection.title,
            style: AppText.titleMd.copyWith(fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 8),
          Container(height: 4, width: 96, color: collection.color),
          const SizedBox(height: 16),
          Text(collection.description, style: AppText.bodyMd),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DIGITAL ARCHIVE',
          style: AppText.labelSm.copyWith(
            color: AppColors.onPrimaryFixedVariant,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Browse Items',
          style: AppText.displayLg.copyWith(
            color: AppColors.primary,
            fontSize: 40,
          ),
        ),
        const SizedBox(height: 8),
        Container(height: 4, width: 96, color: AppColors.primary),
      ],
    );
  }

  Widget _buildSearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          controller: _searchController,
          autofocus: widget.autofocusSearch,
          onChanged: (v) => setState(() => _query = v.trim()),
          style: AppText.bodyLg.copyWith(color: AppColors.onSurface),
          cursorColor: AppColors.secondary,
          decoration: InputDecoration(
            isDense: true,
            hintText: 'Search the heritage…',
            hintStyle: AppText.bodyLg.copyWith(
              color: AppColors.outline.withValues(alpha: 0.5),
            ),
            suffixIcon: const Icon(Icons.search, color: AppColors.outline),
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.outlineVariant),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondary),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTagFilter() {
    final tags = {for (final i in _source) ...i.tags}.toList()..sort();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final tag in tags) ...[
            _TagChip(
              label: tag,
              active: _activeTag == tag,
              onTap: () => setState(
                () => _activeTag = _activeTag == tag ? null : tag,
              ),
            ),
            const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.outlineVariant,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        children: [
          Icon(Icons.search_off,
              size: 48, color: AppColors.outline.withValues(alpha: 0.5)),
          const SizedBox(height: 12),
          Text(
            _source.isEmpty
                ? 'This collection is still being gathered.\n'
                    'Have something to add? Contribute an item.'
                : 'No items found in the repository.',
            textAlign: TextAlign.center,
            style: AppText.bodyMd.copyWith(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterCount(int shown, int total) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          children: [
            Container(width: 48, height: 1, color: AppColors.outlineVariant),
            const SizedBox(height: 16),
            Text(
              _activeTag == null && _query.isEmpty
                  ? '$shown of $total items in the repository'
                  : '$shown of $total items match',
              style: AppText.labelSm.copyWith(
                color: AppColors.onSurfaceVariant.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A filter chip styled as a faded fabric tag.
class _TagChip extends StatelessWidget {
  const _TagChip({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: active
              ? AppColors.secondaryContainer
              : AppColors.secondaryContainer.withValues(alpha: 0.12),
          border: Border.all(
            color: active
                ? AppColors.secondary
                : AppColors.secondary.withValues(alpha: 0.25),
          ),
        ),
        child: Text(
          label,
          style: AppText.labelSm.copyWith(
            color: active
                ? AppColors.onSecondaryContainer
                : AppColors.secondary,
          ),
        ),
      ),
    );
  }
}

/// One archive item rendered as a filed card: a 3:4 plate, a catalog badge,
/// title, tags, and a "View Details" affordance.
class _ItemCard extends StatelessWidget {
  const _ItemCard({required this.item});

  final ArchiveItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ItemDetailScreen(item: item)),
      ),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(
            color: AppColors.outline.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Plate with catalog badge.
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: ArchiveImage(
                    icon: item.kind.icon,
                    caption: item.caption,
                    asset: item.image,
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    color: AppColors.primary,
                    child: Text(
                      'Item #${item.catalogNo}',
                      style: AppText.labelSm.copyWith(
                        color: AppColors.onPrimary,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    color: AppColors.surface.withValues(alpha: 0.85),
                    child: Text(
                      item.kind.label.toUpperCase(),
                      style: AppText.labelSm.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Caption block.
            Container(
              color: AppColors.surfaceBright,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: AppText.titleMd.copyWith(height: 1.2),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      for (final t in item.tags.take(3))
                        Text(
                          '#$t',
                          style: AppText.labelSm.copyWith(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            color:
                                AppColors.onSurfaceVariant.withValues(alpha: 0.7),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'VIEW DETAILS',
                        style: AppText.labelSm.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.open_in_new,
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
