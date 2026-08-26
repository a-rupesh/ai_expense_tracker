<<<<<<< HEAD
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final bool loading;
  final VoidCallback onPressed;

  const AuthButton({
    super.key,
    required this.text,
    required this.loading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton(
        onPressed: loading ? null : onPressed,

        child: loading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
=======
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final bool loading;
  final VoidCallback onPressed;

  const AuthButton({
    super.key,
    required this.text,
    required this.loading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton(
        onPressed: loading ? null : onPressed,

        child: loading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
>>>>>>> 656d780915e823b4356a161e248a42e061f060ed
}