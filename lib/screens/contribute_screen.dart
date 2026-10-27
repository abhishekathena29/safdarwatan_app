import 'package:flutter/material.dart';

import '../data/archive_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/seal_tag.dart';
import '../widgets/vintage_button.dart';
import 'web_page_screen.dart';

/// The item types offered by the site's Contribution form, in its order.
const _contributionTypes = [
  (Icons.auto_stories, 'Story', 'A memory, folktale or family history.'),
  (Icons.image, 'Image', 'Photographs, documents, artwork.'),
  (Icons.music_note, 'Sound or Music', 'Songs, recordings, oral accounts.'),
  (Icons.language, 'Website', 'A page or resource about Kashmir.'),
  (Icons.view_in_ar, 'Interactive Resource', 'Including 3D models.'),
  (Icons.videocam, 'Video', 'Films, events, documentation.'),
];

/// Contribute an Item — invites the community to add to the archive, then
/// opens the site's own contribution form (reCAPTCHA-protected) in-app.
class ContributeScreen extends StatelessWidget {
  const ContributeScreen({super.key});

  static const _margin = 20.0;

  static void openForm(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const WebPageScreen(
          title: 'Contribute an Item',
          url: kContributeUrl,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(_margin, 16, _margin, 120),
      children: [
        _buildHeader(),
        const SizedBox(height: 32),
        _buildTypes(),
        const SizedBox(height: 40),
        _buildSteps(),
        const SizedBox(height: 32),
        Center(
          child: VintageButton(
            label: 'Contribute an Item',
            onPressed: () => openForm(context),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          ),
        ),
        const SizedBox(height: 24),
        _buildTerms(context),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SHARE YOUR HERITAGE',
          style: AppText.labelSm.copyWith(
            color: AppColors.primary,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Contribute',
          style: AppText.displayLg.copyWith(
            color: AppColors.primary,
            fontSize: 40,
          ),
        ),
        const SizedBox(height: 8),
        Container(height: 4, width: 96, color: AppColors.primary),
        const SizedBox(height: 16),
        Text(
          'Cultural heritage is a shared resource. Add a story, a song, a '
          'photograph or a film to the archive so that the spirit of Kashmir '
          'stays alive for future generations.',
          style: AppText.bodyLg,
        ),
      ],
    );
  }

  Widget _buildTypes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'WHAT CAN YOU CONTRIBUTE?',
          style: AppText.labelSm.copyWith(
            color: AppColors.onSurfaceVariant.withValues(alpha: 0.7),
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 16),
        // Pairs of equal-height tiles that size to their text, so nothing
        // clips on narrow phones or with large system fonts.
        for (int i = 0; i < _contributionTypes.length; i += 2) ...[
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: _typeTile(_contributionTypes[i])),
                const SizedBox(width: 12),
                Expanded(child: _typeTile(_contributionTypes[i + 1])),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }

  Widget _typeTile((IconData, String, String) type) {
    final (icon, label, note) = type;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(height: 16),
          Text(
            label.toUpperCase(),
            style: AppText.labelSm.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            note,
            style: AppText.labelSm.copyWith(
              fontStyle: FontStyle.italic,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSteps() {
    const steps = [
      'Choose the type of item you want to contribute.',
      'Describe it and attach your file or link.',
      'Add your name and email address (both required).',
      'Choose whether to publish your contribution on the web.',
      'Agree to the Terms and Conditions and submit.',
    ];
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.secondaryContainer.withValues(alpha: 0.2),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SealTag(label: 'How it works', color: AppColors.secondary),
          const SizedBox(height: 16),
          for (int i = 0; i < steps.length; i++) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 32,
                  child: Text(
                    '0${i + 1}',
                    style: AppText.labelSm.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      height: 1.6,
                    ),
                  ),
                ),
                Expanded(child: Text(steps[i], style: AppText.bodyMd)),
              ],
            ),
            if (i < steps.length - 1) const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }

  Widget _buildTerms(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const WebPageScreen(
              title: 'Terms and Conditions',
              url: kContributionTermsUrl,
            ),
          ),
        ),
        child: Text(
          'Read the Terms and Conditions',
          style: AppText.labelSm.copyWith(
            color: AppColors.primary,
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.dotted,
          ),
        ),
      ),
    );
  }
}
