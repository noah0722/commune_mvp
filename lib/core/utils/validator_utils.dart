class ValidatorUtils {
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName은(는) 필수에요';
    }
    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '닉네임은 필수에요';
    }
    if (value.length < 2) {
      return '닉네임은 2글자 이상이어야 해요';
    }
    if (value.length > 20) {
      return '닉네임은 20글자 이하여야 해요';
    }
    return null;
  }

  static String? validatePostTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '제목은 필수에요';
    }
    if (value.length < 2) {
      return '제목은 2글자 이상이어야 해요';
    }
    if (value.length > 100) {
      return '제목은 100글자 이하여야 해요';
    }
    return null;
  }

  static String? validateUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '링크를 입력해주세요';
    }

    try {
      final uri = Uri.parse(value);
      if (!uri.hasScheme || !uri.hasAuthority) {
        return '올바른 링크 형식이 아니에요';
      }
      return null;
    } catch (e) {
      return '올바른 링크 형식이 아니에요';
    }
  }

  static String? validateMuName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '뮤 이름은 필수에요';
    }
    if (value.length < 2) {
      return '뮤 이름은 2글자 이상이어야 해요';
    }
    if (value.length > 30) {
      return '뮤 이름은 30글자 이하여야 해요';
    }

    // Check for special characters except underscore
    if (!RegExp(r'^[가-힣a-zA-Z0-9_]+$').hasMatch(value)) {
      return '뮤 이름은 한글, 영문, 숫자, 언더바(_)만 사용할 수 있어요';
    }

    return null;
  }
}

enum FileType {
  image,
  video,
}

class FileValidationResult {
  FileValidationResult({
    required this.isValid,
    this.error,
  });
  final bool isValid;
  final String? error;
}
