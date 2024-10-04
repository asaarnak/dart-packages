import 'package:flutter/material.dart';

class _NoSplashFactory extends InteractiveInkFeatureFactory {
  const _NoSplashFactory();

  @override
  InteractiveInkFeature create({
    required MaterialInkController controller,
    required RenderBox referenceBox,
    required Offset position,
    required Color color,
    required TextDirection textDirection,
    bool containedInkWell = false,
    RectCallback? rectCallback,
    BorderRadius? borderRadius,
    ShapeBorder? customBorder,
    double? radius,
    VoidCallback? onRemoved,
  }) {
    // ignore: deprecated_member_use_from_same_package
    return NoSplash(
      controller: controller,
      referenceBox: referenceBox,
      color: color,
      onRemoved: onRemoved,
    );
  }
}

/// This class disables the splash effect.
@Deprecated(
  'Use Flutters inbuild NoSplash: '
  'https://api.flutter.dev/flutter/material/NoSplash-class.html',
)
class NoSplash extends InteractiveInkFeature {
  NoSplash({
    required super.controller,
    required super.referenceBox,
    required super.color,
    super.onRemoved,
  });

  static const InteractiveInkFeatureFactory splashFactory = _NoSplashFactory();

  @override
  void paintFeature(Canvas canvas, Matrix4 transform) {}
}
