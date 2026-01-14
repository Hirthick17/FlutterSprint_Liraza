import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/mood_service.dart';

class MoodState {
  final String? selectedMood;
  final bool isLoading;
  final String? error;

  MoodState({
    this.selectedMood,
    this.isLoading = false,
    this.error,
  });

  MoodState copyWith({
    String? selectedMood,
    bool? isLoading,
    String? error,
  }) {
    return MoodState(
      selectedMood: selectedMood ?? this.selectedMood,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class MoodNotifier extends StateNotifier<MoodState> {
  final MoodService _moodService;

  MoodNotifier(this._moodService) : super(MoodState());

  Future<void> logMood(String mood) async {
    // Optimistic update - show selected immediately
    state = state.copyWith(isLoading: true, error: null);
    debugPrint('Logging mood: $mood');
    
    try {
      // This will now succeed even if offline/unauth thanks to service fallback
      await _moodService.logMood(mood);
      state = state.copyWith(
        selectedMood: mood,
        isLoading: false,
      );
      debugPrint('Mood log success: $mood');
    } catch (e) {
      debugPrint('Mood log error (handled): $e');
      // Even if service throws (unlikely now), keep the selection visual
      state = state.copyWith(
        selectedMood: mood, // Keep selected visually
        isLoading: false,
        // error: e.toString(), // Don't show error to user, just log it
      );
    }
  }

  void clearSelection() {
    state = MoodState();
  }
}

final moodServiceProvider = Provider<MoodService>((ref) => MoodService());

final moodProvider = StateNotifierProvider<MoodNotifier, MoodState>((ref) {
  final moodService = ref.watch(moodServiceProvider);
  return MoodNotifier(moodService);
});
