import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../data/archive_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/link_opener.dart';

/// Hides the Omeka theme's header, banner and footer so an embedded form
/// reads as part of the app rather than a website inside it.
const _chromeCss = '''
header, footer, .banner, #skipnav, .main-header, .main-footer,
#search-container, .cookie-consent, #ga-opt { display: none !important; }
body { background: #FCF9F2 !important; }
#main-content, #primary { padding-top: 8px !important; margin-top: 0 !important; }
''';

/// Shows a page of safardarwatan.omeka.net inside the app — used for the
/// Contribute and Contact forms, which are protected by reCAPTCHA and so must
/// be submitted through the site itself.
class WebPageScreen extends StatefulWidget {
  const WebPageScreen({super.key, required this.title, required this.url});

  final String title;
  final String url;

  @override
  State<WebPageScreen> createState() => _WebPageScreenState();
}

class _WebPageScreenState extends State<WebPageScreen> {
  late final WebViewController _controller;
  int _progress = 0;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.background)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (p) => setState(() => _progress = p),
          onPageStarted: (_) => setState(() => _failed = false),
          onPageFinished: (_) => _controller.runJavaScript(
            "var s=document.createElement('style');"
            's.innerHTML=${_jsString(_chromeCss)};'
            'document.head.appendChild(s);',
          ),
          onWebResourceError: (e) {
            if (e.isForMainFrame ?? true) setState(() => _failed = true);
          },
          onNavigationRequest: (req) {
            // Keep the site in-app; send everything else to the browser.
            final uri = Uri.parse(req.url);
            final internal = uri.host.endsWith('omeka.net') ||
                uri.host.contains('recaptcha') ||
                uri.host.contains('google') ||
                uri.host.contains('gstatic') ||
                uri.scheme == 'about';
            if (internal) return NavigationDecision.navigate;
            openLink(context, req.url);
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  static String _jsString(String s) =>
      "'${s.replaceAll('\n', ' ').replaceAll("'", "\\'")}'";

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
          onPressed: () async {
            if (await _controller.canGoBack()) {
              _controller.goBack();
            } else if (context.mounted) {
              Navigator.of(context).maybePop();
            }
          },
        ),
        title: Text(
          widget.title.toUpperCase(),
          style: AppText.labelSm.copyWith(
            color: AppColors.onSurfaceVariant,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Open in browser',
            icon: const Icon(Icons.open_in_browser, color: AppColors.primary),
            onPressed: () => openLink(context, widget.url),
          ),
        ],
        shape: const Border(
          bottom: BorderSide(color: AppColors.outlineVariant),
        ),
        bottom: _progress < 100
            ? PreferredSize(
                preferredSize: const Size.fromHeight(2),
                child: LinearProgressIndicator(
                  value: _progress / 100,
                  minHeight: 2,
                  color: AppColors.secondary,
                  backgroundColor: Colors.transparent,
                ),
              )
            : null,
      ),
      body: _failed ? _buildOffline() : WebViewWidget(controller: _controller),
    );
  }

  Widget _buildOffline() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi_off,
                size: 48, color: AppColors.outline.withValues(alpha: 0.6)),
            const SizedBox(height: 16),
            Text(
              'This page needs an internet connection.',
              textAlign: TextAlign.center,
              style: AppText.bodyLg,
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => _controller.loadRequest(Uri.parse(widget.url)),
              child: Text(
                'TRY AGAIN',
                style: AppText.labelSm.copyWith(color: AppColors.primary),
              ),
            ),
            Text(
              kSiteUrl.replaceFirst('https://', ''),
              style: AppText.labelSm,
            ),
          ],
        ),
      ),
    );
  }
}
