import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/features/post/providers/media_upload_provider.dart';
import 'package:commune/core/widgets/media_preview.dart';

class MediaUploadField extends ConsumerWidget {
  final TextEditingController controller;

  const MediaUploadField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uploadState = ref.watch(mediaUploadProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  ref.read(mediaUploadProvider.notifier).pickMedia();
                },
                icon: const Icon(Icons.add_photo_alternate),
                label: const Text('이미지/동영상 추가'),
              ),
            ),
            if (uploadState.mediaUrls.isNotEmpty) ...[
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: () {
                  ref.read(mediaUploadProvider.notifier).clearMedia();
                },
                icon: const Icon(Icons.clear),
                label: const Text('전체 삭제'),
              ),
            ],
          ],
        ),  const SizedBox(height: 8),
        if (uploadState.isLoading)
          const Center(
            child: CircularProgressIndicator(),
          )
        else if (uploadState.mediaUrls.isNotEmpty)
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: uploadState.mediaUrls.length,
              itemBuilder: (context, index) {
                final url = uploadState.mediaUrls[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Stack(
                    children: [
                      MediaPreview(
                        url: url,
                        height: 200,
                        width: 200,
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.black54,
                            padding: const EdgeInsets.all(4),
                          ),
                          onPressed: () {
                            ref.read(mediaUploadProvider.notifier)
                                .removeMedia(index);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        const SizedBox(height: 16),
        TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: '내용을 입력하세요 (선택사항)',
          ),
          maxLines: 3,
        ),
      ],
    );
  }
}