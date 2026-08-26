<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingSkeleton extends StatelessWidget {
  final double height;
  final double width;
  final BorderRadius borderRadius;

  const LoadingSkeleton({
    super.key,
    this.height = 20,
    this.width = double.infinity,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(12),
    ),
  });

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor:
          isDark ? Colors.grey.shade800 : Colors.grey.shade300,
      highlightColor:
          isDark ? Colors.grey.shade700 : Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
=======
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingSkeleton extends StatelessWidget {
  final double height;
  final double width;
  final BorderRadius borderRadius;

  const LoadingSkeleton({
    super.key,
    this.height = 20,
    this.width = double.infinity,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(12),
    ),
  });

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor:
          isDark ? Colors.grey.shade800 : Colors.grey.shade300,
      highlightColor:
          isDark ? Colors.grey.shade700 : Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
>>>>>>> 656d780915e823b4356a161e248a42e061f060ed
}