import 'package:flutter/material.dart';

/// Gambar menu dari internet dengan indikator loading dan fallback saat error,
/// jadi tampilan tetap rapi (dan tidak crash) walau gambar gagal dimuat.
class MenuImage extends StatelessWidget {
  const MenuImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.resolution = 600,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final int resolution;

  String get _resizedUrl {
    final separator = url.contains('?') ? '&' : '?';
    return '$url${separator}auto=format&fit=crop&w=$resolution&q=80';
  }

  @override
  Widget build(BuildContext context) {
    return Image.network(
      _resizedUrl,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return _ImagePlaceholder(
          width: width,
          height: height,
          child: const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return _ImagePlaceholder(
          width: width,
          height: height,
          child: const Icon(Icons.restaurant, color: Colors.grey),
        );
      },
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({this.width, this.height, required this.child});

  final double? width;
  final double? height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: child,
    );
  }
}
