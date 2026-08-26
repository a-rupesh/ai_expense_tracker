<<<<<<< HEAD
import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        CircleAvatar(
          radius: 42,
          backgroundColor: colorScheme.primary.withOpacity(0.12),
          child: Icon(
            Icons.account_balance_wallet_rounded,
            size: 42,
            color: colorScheme.primary,
          ),
        ),

        const SizedBox(height: 24),

        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),

        const SizedBox(height: 8),

        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(.75),
              ),
        ),
      ],
    );
  }
=======
import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        CircleAvatar(
          radius: 42,
          backgroundColor: colorScheme.primary.withOpacity(0.12),
          child: Icon(
            Icons.account_balance_wallet_rounded,
            size: 42,
            color: colorScheme.primary,
          ),
        ),

        const SizedBox(height: 24),

        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),

        const SizedBox(height: 8),

        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(.75),
              ),
        ),
      ],
    );
  }
>>>>>>> 656d780915e823b4356a161e248a42e061f060ed
}