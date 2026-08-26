<<<<<<< HEAD
import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {

  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      elevation: 4,

      child: Padding(

        padding: const EdgeInsets.symmetric(
    vertical: 12,
    horizontal: 10,),

        child: Column(

          children: [

            Icon(
              icon,
              color: color,
              size: 28,
            ),

            const SizedBox(height: 6),

            Text(title),

            const SizedBox(height: 8),

            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

          ],

        ),

      ),

    );

  }
=======
import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {

  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      elevation: 4,

      child: Padding(

        padding: const EdgeInsets.symmetric(
    vertical: 12,
    horizontal: 10,),

        child: Column(

          children: [

            Icon(
              icon,
              color: color,
              size: 28,
            ),

            const SizedBox(height: 6),

            Text(title),

            const SizedBox(height: 8),

            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

          ],

        ),

      ),

    );

  }
>>>>>>> 656d780915e823b4356a161e248a42e061f060ed
}