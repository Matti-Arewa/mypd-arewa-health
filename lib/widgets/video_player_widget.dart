import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final String title;
  final String description;

  const VideoPlayerWidget({
    Key? key,
    required this.videoUrl,
    required this.title,
    this.description = '',
  }) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isInitialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      if (widget.videoUrl.startsWith('http')) {
        _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
      } else {
        _videoPlayerController = VideoPlayerController.asset(widget.videoUrl);
      }

      await _videoPlayerController.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: false,
        looping: false,
        aspectRatio: _videoPlayerController.value.aspectRatio,
        placeholder: const Center(
          child: const CircularProgressIndicator(),
        ),
        errorBuilder: (context, errorMessage) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 48,
                ),
                SizedBox(height: 8),
                Text(
                  'Error loading video',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          );
        },
      );

      setState(() {
        _isInitialized = true;
      });
    } catch (error) {
      print('Error initializing video player: $error');
      setState(() {
        _hasError = true;
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 2,
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),

          // Video player
          AspectRatio(
            aspectRatio: 16 / 9,
            child: _isInitialized
                ? Chewie(controller: _chewieController!)
                : _hasError
                ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 48,
                  ),
                  SizedBox(height: 8),
                  Text('Unable to load video'),
                ],
              ),
            )
                : const Center(
              child: CircularProgressIndicator(),
            ),
          ),

          // Description
          if (widget.description.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
        ],
      ),
    );
  }
}