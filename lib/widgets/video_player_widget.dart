import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import '../utils/app_theme.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final String title;
  final String description;
  final bool autoPlay;

  const VideoPlayerWidget({
    super.key,
    required this.videoUrl,
    required this.title,
    this.description = '',
    this.autoPlay = true,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _isInitialized = false;
  bool _hasError = false;
  bool _videoExists = false;

  @override
  void initState() {
    super.initState();
    _checkVideoExists();
  }

  Future<void> _checkVideoExists() async {
    try {
      // Check if the video exists
      if (widget.videoUrl.startsWith('http')) {
        // For network videos, we'll try to initialize directly
        _videoExists = true;
        _initializePlayer();
      } else {
        // For asset videos, check if the file exists
        try {
          await rootBundle.load(widget.videoUrl);
          _videoExists = true;
          _initializePlayer();
        } catch (e) {
          print('Video asset not found: ${widget.videoUrl}');
          setState(() {
            _videoExists = false;
            _hasError = true;
          });
        }
      }
    } catch (e) {
      print('Error checking video: $e');
      setState(() {
        _hasError = true;
      });
    }
  }

  Future<void> _initializePlayer() async {
    if (!_videoExists) return;

    try {
      if (widget.videoUrl.startsWith('http')) {
        _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
      } else {
        _videoPlayerController = VideoPlayerController.asset(widget.videoUrl);
      }

      await _videoPlayerController!.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: widget.autoPlay,
        looping: false,
        aspectRatio: _videoPlayerController!.value.aspectRatio,
        placeholder: const Center(
          child: CircularProgressIndicator(),
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
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final bool isSmallScreen = MediaQuery.of(context).size.width < 360;

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 2,
      margin: const EdgeInsets.all(0),
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

          // Video player or placeholder
          AspectRatio(
            aspectRatio: 16 / 9,
            child: _isInitialized
                ? Chewie(controller: _chewieController!)
                : _hasError || !_videoExists
                ? _buildPlaceholder(context)
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

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.video_library,
              color: AppTheme.primaryColor,
              size: 48,
            ),
            SizedBox(height: 16),
            Text(
              'Video coming soon',
              style: TextStyle(
                color: AppTheme.textPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}