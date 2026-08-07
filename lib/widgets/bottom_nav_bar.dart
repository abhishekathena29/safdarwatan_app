import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// A bottom navigation destination.
class NavDestination {
  const NavDestination(this.icon, this.label);
  final IconData icon;
  final String label;
}

const List<NavDestination> kNavDestinations = [
  NavDestination(Icons.home, 'Home'),
  NavDestination(Icons.account_balance, 'Archive'),
  NavDestination(Icons.grid_view, 'Explore'),
  NavDestination(Icons.map, 'Map'),
  NavDestination(Icons.mic, 'Voices'),
];

/// Virtual route index for Thematic Exhibits — reachable from the drawer only,
/// so it has no slot in the bottom navigation bar.
const int kThematicExhibitsIndex = 5;

/// Semi-transparent, blurred bottom navigation over the aged-paper surface.
/// The active item sits in a "primary-fixed" pill (DESIGN.md → Navigation).
class HeirloomBottomNav extends StatelessWidget {
  const HeirloomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.9),
            border: const Border(
              top: BorderSide(color: AppColors.outlineVariant),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  for (int i = 0; i < kNavDestinations.length; i++)
                    Expanded(
                      child: _NavItem(
                        destination: kNavDestinations[i],
                        active: i == currentIndex,
                        onTap: () => onTap(i),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.destination,
    required this.active,
    required this.onTap,
  });

  final NavDestination destination;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color =
        active ? AppColors.primary : AppColors.onSurfaceVariant.withValues(alpha: 0.7);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      // Align (not Center) with heightFactor 1.0 centres the pill horizontally
      // within its Expanded slot while hugging the child's height — a plain
      // Center would expand vertically and swallow the whole screen.
      child: Align(
        alignment: Alignment.center,
        heightFactor: 1.0,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding:
              EdgeInsets.symmetric(horizontal: active ? 10 : 4, vertical: 4),
          decoration: BoxDecoration(
            color: active ? AppColors.primaryFixed : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(destination.icon, size: 24, color: color),
              const SizedBox(height: 2),
              // Shrink the label to fit its slot so the bar never overflows
              // on narrow phones.
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  destination.label.toUpperCase(),
                  maxLines: 1,
                  style: AppText.labelSm
                      .copyWith(color: color, letterSpacing: -0.2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
