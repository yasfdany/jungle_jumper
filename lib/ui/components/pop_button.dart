import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:jungle_jumper/utils/extensions.dart';

import '../../r.dart';

class PopButton extends StatefulWidget {
  final String? text;
  final double? textSize;
  final VoidCallback? onTap;
  final Color? color;
  final Color? textColor;
  final Color? shadowColor;
  final Widget? child;
  final EdgeInsets? padding;
  final Border? border;
  final double? radius;
  final MainAxisAlignment? axisAlignment;

  const PopButton({
    super.key,
    this.text,
    this.textSize,
    this.onTap,
    this.color,
    this.textColor,
    this.shadowColor,
    this.child,
    this.padding,
    this.border,
    this.radius,
    this.axisAlignment = MainAxisAlignment.center,
  });

  @override
  PopButtonState createState() => PopButtonState();
}

class PopButtonState extends State<PopButton>
    with SingleTickerProviderStateMixin {
  late AnimationController poppingAnimationController;
  Color? textColor;

  @override
  void dispose() {
    poppingAnimationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    poppingAnimationController = AnimationController(
      vsync: this,
      value: 1,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.textColor == null) {
      textColor = Colors.white;
    } else {
      textColor = widget.textColor;
    }

    Widget child = ClipRRect(
      borderRadius: BorderRadius.circular(widget.radius ?? 6),
      child: Padding(
        padding: widget.padding ?? const EdgeInsets.all(16),
        child: Center(
          child: widget.child ??
              Text(
                widget.text ?? '',
                style: TextStyle(
                  fontSize: widget.textSize ?? 24,
                  fontFamily: "monogram",
                  color: Colors.black,
                ),
              ),
        ),
      ),
    );

    Widget container = AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      decoration: BoxDecoration(
        border: widget.border,
        color: widget.color ?? Colors.white,
        borderRadius: BorderRadius.circular(widget.radius ?? 6),
      ),
      child: child,
    );

    return GestureDetector(
      onTapCancel: () {
        poppingAnimationController.animateTo(1);
      },
      onTap: () {
        poppingAnimationController.animateTo(0.9).whenComplete(() {
          poppingAnimationController.animateTo(1).whenComplete(() {
            FlameAudio.play(AssetAudio.tap.fileName, volume: 1);
            widget.onTap?.call();
          });
        });
      },
      onTapDown: (_) {
        poppingAnimationController.animateTo(0.9);
      },
      child: AnimatedBuilder(
        animation: poppingAnimationController,
        builder: (context, _) {
          return Transform.scale(
            scale: poppingAnimationController.value,
            child: widget.child ?? container,
          );
        },
      ),
    );
  }
}
