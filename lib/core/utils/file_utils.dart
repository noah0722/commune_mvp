import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class FileUtils {
  static Future<String> generateUniqueFileName(String originalPath) async {
    final extension = path.extension(originalPath);
    final uuid = const Uuid().v4();
    return '$uuid$extension';
  }

  static Future<FileValidationResult> validateFile(
    XFile file,
    FileType type,
  ) async {
    try {
      final mimeType = lookupMimeType(file.path);
      final size = await file.length();
      
      // Maximum file sizes
      const maxImageSize = 10 * 1024 * 1024; // 10MB
      const maxVideoSize = 100 * 1024 * 1024; // 100MB
      
      switch (type) {
        case FileType.image:
          if (!mimeType!.startsWith('image/')) {
            return FileValidationResult(
              isValid: false,
              error: '이미지 파일만 업로드할 수 있어요',
            );
          }
          if (size > maxImageSize) {
            return FileValidationResult(
              isValid: false,
              error: '이미지 크기는 10MB 이하여야 해요',
            );
          }
          break;
          
        case FileType.video:
          if (!mimeType!.startsWith('video/')) {
            return FileValidationResult(
              isValid: false,
              error: '동영상 파일만 업로드할 수 있어요',
            );
          }
          if (size > maxVideoSize) {
            return FileValidationResult(
              isValid: false,
              error: '동영상 크기는 100MB 이하여야 해요',
            );
          }
          break;
      }

      return FileValidationResult(isValid: true);
    } catch (e) {
      return FileValidationResult(
        isValid: false,
        error: '파일 검증 중 오류가 발생했어요',
      );
    }
  }

  static bool isVideoFile(String path) {
    final mimeType = lookupMimeType(path);
    return mimeType != null && mimeType.startsWith('video/');
  }

  static bool isImageFile(String path) {
    final mimeType = lookupMimeType(path);
    return mimeType != null && mimeType.startsWith('image/');
  }

  static String getFileExtension(String fileName) {
    return path.extension(fileName);
  }
}

enum FileType {
  image,
  video,
}

class FileValidationResult {
  final bool isValid;
  final String? error;

  FileValidationResult({
    required this.isValid,
    this.error,
  });
}
