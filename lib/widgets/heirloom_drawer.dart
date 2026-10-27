import 'package:flutter/material.dart';

import '../data/archive_data.dart';
import '../screens/about_pages_screen.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'bottom_nav_bar.dart';
import 'link_opener.dart';

class _DrawerEntry {
  const _DrawerEntry(this.icon, this.label, this.index, {this.open});
  final IconData icon;
  final String label;

  /// Maps to a bottom-nav index, or -1 if it has no bottom-nav equivalent.
  final int index;

  /// Action for entries that push a page instead of switching tabs.
  final void Function(BuildContext context)? open;
}

// Mirrors the site's main menu.
final _entries = [
  const _DrawerEntry(Icons.history_edu, 'Home/About', 0),
  _DrawerEntry(
    Icons.flag_outlined,
    'Mission & Vision',
    -1,
    open: (c) => Navigator.of(c).push(
      MaterialPageRoute(builder: (_) => const AboutPagesScreen()),
    ),
  ),
  const _DrawerEntry(Icons.auto_stories, 'Browse Items', 1),
  const _DrawerEntry(Icons.category, 'Collections', 2),
  const _DrawerEntry(Icons.museum, 'Thematic Exhibits', kThematicExhibitsIndex),
  const _DrawerEntry(Icons.explore, 'Geographical Map', 3),
  const _DrawerEntry(
      Icons.volunteer_activism, 'Contribute an Item', kContributeIndex),
  _DrawerEntry(
    Icons.mail_outline,
    'Contact Us',
    -1,
    open: AboutPagesScreen.openContact,
  ),
  _DrawerEntry(
    Icons.settings_voice,
    'Community Podcast',
    -1,
    open: (c) => openLink(c, kSpotifyShowUrl),
  ),
];

/// Slide-in navigation drawer styled as an archival index.
class HeirloomDrawer extends StatelessWidget {
  const HeirloomDrawer({
    super.key,
    required this.activeIndex,
    required this.onSelect,
  });

  final int activeIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 320,
      backgroundColor: AppColors.surfaceBright,
      shape: const Border(
        right: BorderSide(color: AppColors.outlineVariant),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 8, 40),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Safar Dar Watan',
                      style: AppText.headlineLg.copyWith(color: AppColors.primary),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.onSurfaceVariant),
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  for (final e in _entries) _buildEntry(context, e),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEntry(BuildContext context, _DrawerEntry e) {
    final active = e.index == activeIndex && e.index >= 0;
    return Material(
      color: active ? AppColors.secondaryContainer : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          if (e.index >= 0) {
            onSelect(e.index);
          } else {
            e.open?.call(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Icon(
                e.icon,
                color: active
                    ? AppColors.onSecondaryContainer
                    : AppColors.onSurfaceVariant,
              ),
              const SizedBox(width: 16),
              Text(
                e.label,
                style: AppText.bodyLg.copyWith(
                  color: active
                      ? AppColors.onSecondaryContainer
                      : AppColors.onSurfaceVariant,
                  fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
