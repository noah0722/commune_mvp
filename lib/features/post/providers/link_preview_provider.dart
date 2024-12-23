// #File: lib/features/post/providers/link_preview_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

class LinkPreview {
  final String url;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? siteName;
  final bool isVideo;

  LinkPreview({
    required this.url,
    this.title,
    this.description,
    this.imageUrl,
    this.siteName,
    this.isVideo = false,
  });

  factory LinkPreview.fromJson(Map<String, dynamic> json) {
    return LinkPreview(
      url: json['url'] as String,
      title: json['title'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      siteName: json['siteName'] as String?,
      isVideo: json['isVideo'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'siteName': siteName,
      'isVideo': isVideo,
    };
  }

  LinkPreview copyWith({
    String? url,
    String? title,
    String? description,
    String? imageUrl,
    String? siteName,
    bool? isVideo,
  }) {
    return LinkPreview(
      url: url ?? this.url,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      siteName: siteName ?? this.siteName,
      isVideo: isVideo ?? this.isVideo,
    );
  }
}

final linkPreviewProvider = FutureProvider.family<LinkPreview?, String>((ref, url) async {
  if (url.isEmpty) return null;

  try {
    final isYouTube = url.contains('youtube.com') || url.contains('youtu.be');
    
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) return null;

    final document = parse(response.body);

    // Try Open Graph tags first
    String? title = _getMetaContent(document, 'og:title') ?? 
                   _getMetaContent(document, 'twitter:title');
    String? description = _getMetaContent(document, 'og:description') ?? 
                         _getMetaContent(document, 'twitter:description') ??
                         _getMetaContent(document, 'description');
    String? imageUrl = _getMetaContent(document, 'og:image') ?? 
                      _getMetaContent(document, 'twitter:image');
    String? siteName = _getMetaContent(document, 'og:site_name');

    // Fallback to basic HTML tags
    if (title == null || title.isEmpty) {
      final titleElement = document.querySelector('title');
      if (titleElement != null) {
        title = titleElement.text;
      }
    }

    if (description == null || description.isEmpty) {
      final paragraphs = document.querySelectorAll('p');
      if (paragraphs.isNotEmpty) {
        description = paragraphs.first.text;
      }
    }

    // Clean up description
    if (description != null) {
      description = description.replaceAll('\n', ' ').trim();
      if (description.length > 200) {
        description = '${description.substring(0, 197)}...';
      }
    }

    return LinkPreview(
      url: url,
      title: title,
      description: description,
      imageUrl: imageUrl,
      siteName: siteName,
      isVideo: isYouTube,
    );
  } catch (e) {
    // Return basic preview if fetching fails
    return LinkPreview(
      url: url,
      title: url,
      isVideo: url.contains('youtube.com') || url.contains('youtu.be'),
    );
  }
});

String? _getMetaContent(Document document, String property) {
  final element = document.querySelector('meta[property="$property"]') ??
                 document.querySelector('meta[name="$property"]');
  return element?.attributes['content']?.trim();
}

// Cache provider to store previews in memory
final linkPreviewCacheProvider = StateProvider<Map<String, LinkPreview>>((ref) => {});

// Provider that combines fetching and caching
final cachedLinkPreviewProvider = FutureProvider.family<LinkPreview?, String>(
  (ref, url) async {
    final cache = ref.read(linkPreviewCacheProvider);
    
    // Return cached preview if available
    if (cache.containsKey(url)) {
      return cache[url];
    }

    // Fetch new preview
    final preview = await ref.read(linkPreviewProvider(url).future);
    
    // Cache the result
    if (preview != null) {
      ref.read(linkPreviewCacheProvider.notifier).state = {
        ...cache,
        url: preview,
      };
    }

    return preview;
  },
);

// Provider for validating URLs
final urlValidatorProvider = Provider<String? Function(String)>((ref) {
  return (String url) {
    if (url.isEmpty) {
      return '링크를 입력해주세요';
    }

    try {
      final uri = Uri.parse(url);
      if (!uri.hasScheme || !uri.hasAuthority) {
        return '올바른 링크 형식이 아니에요';
      }
      return null;
    } catch (e) {
      return '올바른 링크 형식이 아니에요';
    }
  };
});