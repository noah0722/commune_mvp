import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PollOption {
  final String id;
  final TextEditingController controller;

  PollOption({
    required this.id,
    required this.controller,
  });

  void dispose() {
    controller.dispose();
  }
}

class PollOptionsNotifier extends StateNotifier<List<PollOption>> {
  PollOptionsNotifier()
      : super([
          PollOption(id: '1', controller: TextEditingController()),
          PollOption(id: '2', controller: TextEditingController()),
        ]);

  void addOption() {
    if (state.length >= 10) return;

    state = [
      ...state,
      PollOption(
        id: (state.length + 1).toString(),
        controller: TextEditingController(),
      ),
    ];
  }

  void removeOption(int index) {
    if (state.length <= 2) return;

    final options = List<PollOption>.from(state);
    options[index].dispose();
    options.removeAt(index);
    state = options;
  }

  void reorderOptions(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final options = List<PollOption>.from(state);
    final item = options.removeAt(oldIndex);
    options.insert(newIndex, item);
    state = options;
  }

  Map<String, dynamic> getPollData() {
    return {
      'options': state.map((option) => option.controller.text.trim()).toList(),
      'votes': List.filled(state.length, 0),
      'voters': {},
      'endDate': DateTime.now().add(const Duration(days: 7)),
    };
  }

  @override
  void dispose() {
    for (final option in state) {
      option.dispose();
    }
    super.dispose();
  }
}

final pollOptionsProvider =
    StateNotifierProvider<PollOptionsNotifier, List<PollOption>>(
  (ref) => PollOptionsNotifier(),
);
