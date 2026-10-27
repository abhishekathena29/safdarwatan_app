import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../data/archive_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/archive_image.dart';
import '../widgets/link_opener.dart';
import 'item_detail_screen.dart';

/// Items that share one point on the map (e.g. two interviews in New Delhi).
class _Place {
  _Place(this.point, this.name);
  final LatLng point;
  final String name;
  final List<ArchiveItem> items = [];
}

/// A named camera preset for the region row.
class _Region {
  const _Region(this.label, this.bounds);
  final String label;

  /// Null means "fit every place".
  final LatLngBounds? bounds;
}

/// Geographical Map — every geolocated item from the site's Geolocation
/// plugin, plotted on OpenStreetMap with a card strip beneath.
class MapScreen extends StatefulWidget {
  const MapScreen({super.key, this.focusItemId});

  /// When set, the map opens centred on this item's place.
  final int? focusItemId;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _mapController = MapController();
  final _cardController = PageController(viewportFraction: 0.86);
  late final List<_Place> _places = _buildPlaces();
  int _selected = 0;
  String _region = 'All';

  static final _regions = [
    const _Region('All', null),
    _Region(
      'Kashmir',
      LatLngBounds(const LatLng(33.9, 74.3), const LatLng(34.3, 74.95)),
    ),
    _Region(
      'Delhi',
      LatLngBounds(const LatLng(28.45, 77.05), const LatLng(28.7, 77.3)),
    ),
    _Region(
      'North America',
      LatLngBounds(const LatLng(25, -125), const LatLng(50, -70)),
    ),
  ];

  static List<_Place> _buildPlaces() {
    final byKey = <String, _Place>{};
    for (final item in geolocatedItems) {
      final g = item.geo!;
      final key = '${g.lat.toStringAsFixed(4)},${g.lng.toStringAsFixed(4)}';
      byKey
          .putIfAbsent(key, () => _Place(LatLng(g.lat, g.lng), g.place))
          .items
          .add(item);
    }
    return byKey.values.toList();
  }

  @override
  void initState() {
    super.initState();
    final focus = widget.focusItemId;
    if (focus != null) {
      final i = _places.indexWhere(
        (p) => p.items.any((it) => it.catalogNo == focus),
      );
      if (i >= 0) _selected = i;
    }
  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  LatLngBounds get _allBounds =>
      LatLngBounds.fromPoints([for (final p in _places) p.point]);

  void _select(int i, {bool moveCards = true}) {
    setState(() => _selected = i);
    _mapController.move(
      _places[i].point,
      _mapController.camera.zoom < 9 ? 9 : _mapController.camera.zoom,
    );
    if (moveCards && _cardController.hasClients) {
      _cardController.animateToPage(
        i,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _showRegion(_Region r) {
    setState(() => _region = r.label);
    _mapController.fitCamera(
      CameraFit.bounds(
        bounds: r.bounds ?? _allBounds,
        padding: const EdgeInsets.fromLTRB(48, 80, 48, 170),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final focused = widget.focusItemId != null;
    return Stack(
      children: [
        Positioned.fill(
          child: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCameraFit: focused
                  ? null
                  : CameraFit.bounds(
                      bounds: _allBounds,
                      padding: const EdgeInsets.fromLTRB(48, 80, 48, 170),
                    ),
              initialCenter: _places[_selected].point,
              initialZoom: focused ? 10 : 3,
              minZoom: 2,
              maxZoom: 18,
              backgroundColor: AppColors.surfaceContainer,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.safdarwatan.app',
                // Warm the tiles towards the aged-paper palette.
                tileBuilder: (context, tile, _) => ColorFiltered(
                  colorFilter: const ColorFilter.matrix([
                    0.90, 0.10, 0.05, 0, 8, //
                    0.08, 0.86, 0.06, 0, 4, //
                    0.05, 0.08, 0.72, 0, 0, //
                    0, 0, 0, 1, 0,
                  ]),
                  child: tile,
                ),
              ),
              MarkerLayer(
                markers: [
                  for (int i = 0; i < _places.length; i++)
                    Marker(
                      point: _places[i].point,
                      width: 44,
                      height: 52,
                      alignment: Alignment.topCenter,
                      child: _Pin(
                        count: _places[i].items.length,
                        active: i == _selected,
                        onTap: () => _select(i),
                      ),
                    ),
                ],
              ),
              RichAttributionWidget(
                alignment: AttributionAlignment.bottomLeft,
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                    onTap: () => openLink(
                      context,
                      'https://openstreetmap.org/copyright',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 12,
          left: 0,
          right: 0,
          child: _buildRegionRow(),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 16,
          height: 132,
          child: PageView.builder(
            controller: _cardController,
            itemCount: _places.length,
            onPageChanged: (i) => _select(i, moveCards: false),
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: _PlaceCard(place: _places[i]),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegionRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          for (final r in _regions) ...[
            GestureDetector(
              onTap: () => _showRegion(r),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: _region == r.label
                      ? AppColors.primary
                      : AppColors.surface.withValues(alpha: 0.95),
                  border: Border.all(color: AppColors.primary),
                ),
                child: Text(
                  r.label.toUpperCase(),
                  style: AppText.labelSm.copyWith(
                    color: _region == r.label
                        ? AppColors.onPrimary
                        : AppColors.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}

/// A map pin styled as a wax-seal drop, with a count badge for shared places.
class _Pin extends StatelessWidget {
  const _Pin({required this.count, required this.active, required this.onTap});

  final int count;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.primary : AppColors.onPrimaryFixedVariant;
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Icon(Icons.location_on, size: active ? 48 : 40, color: color),
          if (count > 1)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: AppColors.secondaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$count',
                  style: AppText.labelSm.copyWith(
                    fontSize: 10,
                    color: AppColors.onSecondaryContainer,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PlaceCard extends StatelessWidget {
  const _PlaceCard({required this.place});

  final _Place place;

  void _open(BuildContext context) {
    if (place.items.length == 1) {
      _push(context, place.items.first);
      return;
    }
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surfaceBright,
      shape: const RoundedRectangleBorder(),
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Text(place.name, style: AppText.titleMd),
            ),
            for (final item in place.items)
              ListTile(
                leading: Icon(item.kind.icon, color: AppColors.primary),
                title: Text(item.title, style: AppText.bodyMd),
                subtitle: Text(item.kind.label, style: AppText.labelSm),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _push(context, item);
                },
              ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  void _push(BuildContext context, ArchiveItem item) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ItemDetailScreen(item: item)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final first = place.items.first;
    return GestureDetector(
      onTap: () => _open(context),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.outline.withValues(alpha: 0.4)),
          boxShadow: const [
            BoxShadow(color: AppColors.primary, offset: Offset(3, 3)),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 104,
              child: ArchiveImage(
                icon: first.kind.icon,
                asset: first.image,
                caption: first.image == null ? first.caption : null,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.place,
                            size: 14, color: AppColors.secondary),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            place.name.toUpperCase(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppText.labelSm.copyWith(
                              color: AppColors.secondary,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      place.items.length == 1
                          ? first.title
                          : place.items.map((i) => i.title).join(' · '),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.bodyMd.copyWith(
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      place.items.length == 1
                          ? 'ITEM #${first.catalogNo} · VIEW'
                          : '${place.items.length} ITEMS · VIEW',
                      style: AppText.labelSm.copyWith(
                        color: AppColors.primary,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
