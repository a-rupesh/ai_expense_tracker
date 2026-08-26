<<<<<<< HEAD
import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatCard({
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 22,
          horizontal: 16,
        ),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(.15),
              child: Icon(
                icon,
                color: color,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
=======
import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatCard({
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 22,
          horizontal: 16,
        ),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(.15),
              child: Icon(
                icon,
                color: color,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
>>>>>>> 656d780915e823b4356a161e248a42e061f060ed
}