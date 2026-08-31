import 'package:flutter/material.dart';

import '../../../core/widgets/loading_skeleton.dart';

class AnalyticsLoading extends StatelessWidget {
  const AnalyticsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [

        LoadingSkeleton(
          height: 120,
        ),

        SizedBox(height: 20),

        LoadingSkeleton(
          height: 320,
        ),

        SizedBox(height: 20),

        LoadingSkeleton(
          height: 200,
        ),
      ],
    );
  }
}
