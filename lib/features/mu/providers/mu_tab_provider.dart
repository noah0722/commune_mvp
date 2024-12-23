import 'package:flutter_riverpod/flutter_riverpod.dart';

enum MuTab {
  discussion,
  info,
  official,
}

final selectedMuTabProvider = StateProvider<MuTab>((ref) {
  return MuTab.discussion;
});

final muTabIndexProvider = Provider<int>((ref) {
  final selectedTab = ref.watch(selectedMuTabProvider);
  return MuTab.values.indexOf(selectedTab);
});