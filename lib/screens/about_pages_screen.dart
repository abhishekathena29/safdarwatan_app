import 'package:flutter/material.dart';

import '../data/archive_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/archive_image.dart';
import '../widgets/grain_overlay.dart';
import '../widgets/vintage_button.dart';
import 'web_page_screen.dart';

/// Mission & Vision — the site's two simple pages, plus a way to get in touch.
class AboutPagesScreen extends StatelessWidget {
  const AboutPagesScreen({super.key});

  static void openContact(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            const WebPageScreen(title: 'Contact Us', url: kContactUrl),
      ),
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
          'MISSION & VISION',
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: const ArchiveImage(
                    icon: Icons.landscape,
                    asset: AppImages.banner,
                    aspectRatio: 1800 / 560,
                  ),
                ),
                const SizedBox(height: 40),
                _section('Our Mission', 'I', kMission, AppColors.primary),
                const SizedBox(height: 48),
                _section('Our Vision', 'II', kVision, AppColors.tertiary),
                const SizedBox(height: 48),
                _buildContact(context),
              ],
            ),
          ),
          const Positioned.fill(child: GrainOverlay()),
        ],
      ),
    );
  }

  Widget _section(String title, String numeral, String body, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              numeral,
              style: AppText.displayLg.copyWith(
                color: color.withValues(alpha: 0.2),
                fontSize: 56,
                height: 1,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: AppText.headlineLgMobile.copyWith(
                  color: color,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: color, width: 2)),
          ),
          child: Text(body, style: AppText.bodyLg),
        ),
      ],
    );
  }

  Widget _buildContact(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.mail_outline, color: AppColors.primary),
          const SizedBox(height: 12),
          Text('Get in Touch', style: AppText.titleMd),
          const SizedBox(height: 8),
          Text(
            'Questions, corrections or a story to share? Write to the '
            'Safar Dar Watan team.',
            style: AppText.bodyMd,
          ),
          const SizedBox(height: 24),
          VintageButton(
            label: 'Contact Us',
            onPressed: () => openContact(context),
          ),
        ],
      ),
    );
  }
}
