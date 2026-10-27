import 'package:flutter/material.dart';

import 'screens/browse_items_screen.dart';
import 'screens/collections_screen.dart';
import 'screens/contribute_screen.dart';
import 'screens/home_screen.dart';
import 'screens/map_screen.dart';
import 'screens/thematic_exhibits_screen.dart';
import 'theme/app_colors.dart';
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
  bool _searching = false;

  void _select(int i) => setState(() {
        _index = i;
        _searching = false;
      });

  void _search() => setState(() {
        _index = 1;
        _searching = true;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      drawer: HeirloomDrawer(activeIndex: _index, onSelect: _select),
      appBar: HeirloomAppBar(
        onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
        onSearchTap: _search,
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
        return HomeScreen(
          onBrowseCollection: () => _select(2),
          onBrowseItems: () => _select(1),
          onOpenMap: () => _select(3),
          onContribute: () => _select(kContributeIndex),
        );
      case 1:
        // Keyed so tapping search re-creates it with the field focused.
        return BrowseItemsScreen(
          key: ValueKey(_searching),
          autofocusSearch: _searching,
        );
      case 2:
        return CollectionsScreen(
          onContribute: () => _select(kContributeIndex),
        );
      case 3:
        return const MapScreen();
      case kContributeIndex:
        return const ContributeScreen();
      case kThematicExhibitsIndex:
        return const ThematicExhibitsScreen();
      default:
        return const SizedBox.shrink();
    }
  }
}
