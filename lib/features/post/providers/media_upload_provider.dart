import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:commune/core/services/storage_service.dart';
import 'package:commune/core/utils/file_utils.dart'
    show FileUtils, FileType; // Updated import
import 'package:commune/core/providers/auth_provider.dart';

class MediaUploadState {
  MediaUploadState({
    this.isLoading = false,
    this.mediaUrls = const [],
    this.error,
  });
  final bool isLoading;
  final List<String> mediaUrls;
  final String? error;

  MediaUploadState copyWith({
    bool? isLoading,
    List<String>? mediaUrls,
    String? error,
  }) {
    return MediaUploadState(
      isLoading: isLoading ?? this.isLoading,
      mediaUrls: mediaUrls ?? this.mediaUrls,
      error: error ?? this.error,
    );
  }
}

class MediaUploadNotifier extends StateNotifier<MediaUploadState> {
  MediaUploadNotifier(this._ref) : super(MediaUploadState());
  final Ref _ref;
  final _picker = ImagePicker();

  Future<void> pickMedia() async {
    if (state.mediaUrls.length >= 10) {
      state = state.copyWith(
        error: '최대 10개까지만 업로드할 수 있어요',
      );
      return;
    }

    try {
      final List<XFile> files = await _picker.pickMultiImage();
      if (files.isEmpty) return;

      state = state.copyWith(isLoading: true);

      final user = _ref.read(authStateProvider).value;
      if (user == null) throw Exception('로그인이 필요해요');

      final urls = await Future.wait(
        files.map((file) async {
          // Validate file
          final validation = await FileUtils.validateFile(file, FileType.image);
          if (!validation.isValid) {
            throw validation.error!;
          }

          // Upload file
          final bytes = await file.readAsBytes();
          final fileName = await FileUtils.generateUniqueFileName(file.name);
          final path = 'posts/${user.id}/$fileName';

          return _ref.read(storageServiceProvider).uploadFile(
                path: path,
                bytes: bytes,
                contentType: 'image/jpeg',
              );
        }),
      );

      state = state.copyWith(
        isLoading: false,
        mediaUrls: [...state.mediaUrls, ...urls],
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> pickVideo() async {
    if (state.mediaUrls.isNotEmpty) {
      state = state.copyWith(
        error: '이미지와 동영상은 함께 업로드할 수 없어요',
      );
      return;
    }

    try {
      final file = await _picker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(minutes: 5),
      );
      if (file == null) return;

      state = state.copyWith(isLoading: true);

      final user = _ref.read(authStateProvider).value;
      if (user == null) throw Exception('로그인이 필요해요');

      // Validate file
      final validation = await FileUtils.validateFile(file, FileType.video);
      if (!validation.isValid) {
        throw validation.error!;
      }

      // Upload file
      final bytes = await file.readAsBytes();
      final fileName = await FileUtils.generateUniqueFileName(file.name);
      final path = 'posts/${user.id}/$fileName';

      final url = await _ref.read(storageServiceProvider).uploadFile(
            path: path,
            bytes: bytes,
            contentType: 'video/mp4',
          );

      state = state.copyWith(
        isLoading: false,
        mediaUrls: [url],
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void removeMedia(int index) {
    final urls = List<String>.from(state.mediaUrls);
    urls.removeAt(index);
    state = state.copyWith(mediaUrls: urls);
  }

  void clearMedia() {
    state = state.copyWith(mediaUrls: []);
  }
}

final mediaUploadProvider =
    StateNotifierProvider<MediaUploadNotifier, MediaUploadState>(
  MediaUploadNotifier.new,
);
