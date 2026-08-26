<<<<<<< HEAD
import 'package:flutter/material.dart';

import '../../../core/widgets/loading_skeleton.dart';

class AILoadingCard extends StatelessWidget {
  const AILoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: const [

            LoadingSkeleton(height: 30, width: 160),

            SizedBox(height: 25),

            LoadingSkeleton(height: 20),

            SizedBox(height: 12),

            LoadingSkeleton(height: 20),

            SizedBox(height: 12),

            LoadingSkeleton(height: 20),

            SizedBox(height: 12),

            LoadingSkeleton(height: 20),
          ],
        ),
      ),
    );
  }
=======
import 'package:flutter/material.dart';

import '../../../core/widgets/loading_skeleton.dart';

class AILoadingCard extends StatelessWidget {
  const AILoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: const [

            LoadingSkeleton(height: 30, width: 160),

            SizedBox(height: 25),

            LoadingSkeleton(height: 20),

            SizedBox(height: 12),

            LoadingSkeleton(height: 20),

            SizedBox(height: 12),

            LoadingSkeleton(height: 20),

            SizedBox(height: 12),

            LoadingSkeleton(height: 20),
          ],
        ),
      ),
    );
  }
>>>>>>> 656d780915e823b4356a161e248a42e061f060ed
}