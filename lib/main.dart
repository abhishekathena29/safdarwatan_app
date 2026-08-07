import 'package:flutter/material.dart';

import 'screens/browse_items_screen.dart';
import 'screens/collections_screen.dart';
import 'screens/home_screen.dart';
import 'screens/thematic_exhibits_screen.dart';
import 'theme/app_colors.dart';
import 'theme/app_text_styles.dart';
import 'theme/app_theme.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/grain_overlay.dart';
import 'widgets/heirloom_app_bar.dart';
import 'widgets/heirloom_drawer.dart';

void main() {
  runApp(const SafarDarWatanApp());
}

class SafarDarWatanApp extends StatelessWidget {
  const SafarDarWatanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safar Dar Watan',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const RootShell(),
    );
  }
}

/// App shell: hosts the top bar, drawer, bottom navigation, and the
/// grain overlay that sits above every screen.
class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _index = 0;

  void _select(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      drawer: HeirloomDrawer(activeIndex: _index, onSelect: _select),
      appBar: HeirloomAppBar(
        onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
        onSearchTap: () {},
      ),
      body: Stack(
        children: [
          Positioned.fill(child: _buildBody()),
          const Positioned.fill(child: GrainOverlay()),
        ],
      ),
      bottomNavigationBar: HeirloomBottomNav(
        currentIndex: _index,
        onTap: _select,
      ),
    );
  }

  Widget _buildBody() {
    switch (_index) {
      case 0:
        return HomeScreen(onBrowseCollection: () => _select(2));
      case 1:
        return const BrowseItemsScreen();
      case 2:
        return const CollectionsScreen();
      case kThematicExhibitsIndex:
        return const ThematicExhibitsScreen();
      default:
        return _ComingSoon(label: kNavDestinations[_index].label);
    }
  }
}

/// Placeholder for destinations not yet designed (Archive, Map, Voices).
class _ComingSoon extends StatelessWidget {
  const _ComingSoon({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: AppText.headlineLgMobile),
          const SizedBox(height: 8),
          Text(
            'Coming soon to the archive.',
            style: AppText.bodyMd.copyWith(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
