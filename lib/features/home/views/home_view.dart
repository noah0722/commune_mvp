import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/features/home/widgets/home_app_bar.dart';
import 'package:commune/features/home/widgets/home_feed.dart';
import 'package:commune/features/home/widgets/left_drawer.dart';
import 'package:commune/features/home/widgets/right_drawer.dart';
import 'package:commune/features/navigation/widgets/bottom_nav_bar.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const HomeAppBar(),
      drawer: const LeftDrawer(),
      endDrawer: const RightDrawer(),
      body: const HomeFeed(),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}