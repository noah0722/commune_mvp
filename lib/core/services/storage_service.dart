import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:commune/core/utils/file_utils.dart';

class StorageService {
  final _storage = FirebaseStorage.instance;

  Future<String> uploadFile({
    required String path,
    required Uint8List bytes,
    String? contentType,
    Map<String, String>? metadata,
  }) async {
    try {
      final fileName = await FileUtils.generateUniqueFileName(path);
      final ref = _storage.ref().child(fileName);

      final uploadMetadata = SettableMetadata(
        contentType: contentType,
        customMetadata: {
          'uploaded-by': 'commune-app',
          'original-path': path,
          ...?metadata,
        },
      );

      await ref.putData(bytes, uploadMetadata);
      return ref.getDownloadURL();
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> deleteFile(String path) async {
    try {
      final ref = _storage.ref().child(path);
      await ref.delete();
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> deleteDirectory(String path) async {
    try {
      final result = await _storage.ref().child(path).listAll();

      await Future.wait([
        ...result.items.map((ref) => ref.delete()),
        ...result.prefixes.map(
          (ref) => deleteDirectory(ref.fullPath),
        ),
      ]);
    } catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(dynamic error) {
    if (error is FirebaseException) {
      switch (error.code) {
        case 'unauthorized':
          return '파일 업로드 권한이 없어요';
        case 'canceled':
          return '파일 업로드가 취소되었어요';
        case 'storage/retry-limit-exceeded':
          return '네트워크 상태를 확인해주세요';
        default:
          return '파일 업로드에 실패했어요';
      }
    }
    return error?.toString() ?? '알 수 없는 오류가 발생했어요';
  }
}

final storageServiceProvider = Provider<StorageService>(
  (ref) => StorageService(),
);
