import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Top app bar: a hairline-bordered, slightly translucent bar with the
/// brand wordmark centred between a menu and a search affordance.
class HeirloomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HeirloomAppBar({
    super.key,
    this.onMenuTap,
    this.onSearchTap,
  });

  final VoidCallback? onMenuTap;
  final VoidCallback? onSearchTap;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          bottom: BorderSide(color: AppColors.outlineVariant),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 64,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                IconButton(
                  onPressed: onMenuTap,
                  icon: const Icon(Icons.menu),
                  color: AppColors.primary,
                ),
                Expanded(
                  child: Text(
                    'SAFAR DAR WATAN',
                    textAlign: TextAlign.center,
                    style: AppText.headlineLgMobile.copyWith(
                      color: AppColors.primary,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onSearchTap,
                  icon: const Icon(Icons.search),
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
