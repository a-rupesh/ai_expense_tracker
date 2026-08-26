<<<<<<< HEAD
import 'package:flutter/material.dart';

import 'loading_skeleton.dart';

class DashboardLoading extends StatelessWidget {
  const DashboardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [

        LoadingSkeleton(
          height: 40,
          width: 220,
        ),

        SizedBox(height: 25),

        LoadingSkeleton(
          height: 140,
        ),

        SizedBox(height: 20),

        LoadingSkeleton(
          height: 120,
        ),

        SizedBox(height: 20),

        LoadingSkeleton(
          height: 180,
        ),

        SizedBox(height: 20),

        LoadingSkeleton(
          height: 80,
        ),
      ],
    );
  }
=======
import 'package:flutter/material.dart';

import 'loading_skeleton.dart';

class DashboardLoading extends StatelessWidget {
  const DashboardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [

        LoadingSkeleton(
          height: 40,
          width: 220,
        ),

        SizedBox(height: 25),

        LoadingSkeleton(
          height: 140,
        ),

        SizedBox(height: 20),

        LoadingSkeleton(
          height: 120,
        ),

        SizedBox(height: 20),

        LoadingSkeleton(
          height: 180,
        ),

        SizedBox(height: 20),

        LoadingSkeleton(
          height: 80,
        ),
      ],
    );
  }
>>>>>>> 656d780915e823b4356a161e248a42e061f060ed
}