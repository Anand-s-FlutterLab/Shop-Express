import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:shopexpress/core/app_export.dart';

class GifAnimator extends StatefulWidget {
  final String imagePath;
  final int frames;
  final Duration duration;

  GifAnimator({
    required this.imagePath,
    required this.frames,
    required this.duration,
  });

  @override
  State<GifAnimator> createState() => _GifAnimatorState();
}

class _GifAnimatorState extends State<GifAnimator>
    with TickerProviderStateMixin {
  late FlutterGifController controller;

  void initState() {
    controller = FlutterGifController(vsync: this);
    controller.animateTo(widget.frames - 1, duration: widget.duration);
    controller.addListener(() {
      if (controller.isCompleted) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          height: 200,
          width: 100,
          color: Colors.white,
          child: GifImage(
            fit: BoxFit.scaleDown,
            image: AssetImage(widget.imagePath),
            controller: controller,
          ),
        ),
      ),
    );
  }
}
