import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/archive_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Opens [url] in the matching app (YouTube, Spotify…) or the browser, and
/// tells the reader when nothing on the device can handle it.
Future<void> openLink(BuildContext context, String url) async {
  final messenger = ScaffoldMessenger.maybeOf(context);
  final ok = await launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,
  );
  if (!ok) {
    messenger?.showSnackBar(
      SnackBar(content: Text('Could not open $url')),
    );
  }
}

/// A full-width outlined row for an outbound [MediaLink].
class MediaLinkTile extends StatelessWidget {
  const MediaLinkTile({super.key, required this.link});

  final MediaLink link;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceContainerLow,
      child: InkWell(
        onTap: () => openLink(context, link.url),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.outlineVariant),
          ),
          child: Row(
            children: [
              Icon(link.kind.icon, color: AppColors.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  link.text.toUpperCase(),
                  style: AppText.labelSm.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Icon(Icons.open_in_new, size: 16, color: AppColors.primary),
            ],
          ),
        ),
      ),
    );
  }
}
