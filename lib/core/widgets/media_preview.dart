import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:commune/core/utils/file_utils.dart';

class MediaPreview extends StatefulWidget {
  final String url;
  final double height;
  final double width;
  final BoxFit fit;
  final bool autoPlay;
  final bool showControls;

  const MediaPreview({
    super.key,
    required this.url,
    this.height = 200,
    this.width = 200,
    this.fit = BoxFit.cover,
    this.autoPlay = false,
    this.showControls = true,
  });

  @override
  State<MediaPreview> createState() => _MediaPreviewState();
}

class _MediaPreviewState extends State<MediaPreview> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool get _isVideo => widget.url.contains('.mp4') || widget.url.contains('.mov');

  @override
  void initState() {
    super.initState();
    if (_isVideo) {
      _initializeVideoPlayer();
    }
  }

  Future<void> _initializeVideoPlayer() async {
    _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    await _videoController!.initialize();
    
    _chewieController = ChewieController(
      videoPlayerController: _videoController!,
      autoPlay: widget.autoPlay,
      looping: true,
      showControls: widget.showControls,
      aspectRatio: _videoController!.value.aspectRatio,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
    
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isVideo) {
      if (_chewieController == null) {
        return SizedBox(
          height: widget.height,
          width: widget.width,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      return SizedBox(
        height: widget.height,
        width: widget.width,
        child: Chewie(controller: _chewieController!),
      );
    }

    return CachedNetworkImage(
      imageUrl: widget.url,
      height: widget.height,
      width: widget.width,
      fit: widget.fit,
      placeholder: (context, url) => Container(
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: const Icon(Icons.error),
      ),
    );
  }
}