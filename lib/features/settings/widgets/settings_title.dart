<<<<<<< HEAD
import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {

    return ListTile(

      leading: Icon(icon),

      title: Text(title),

      subtitle:
          subtitle == null
              ? null
              : Text(subtitle!),

      trailing:
          trailing ??
          const Icon(Icons.chevron_right),

      onTap: onTap,
    );
  }
=======
import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {

    return ListTile(

      leading: Icon(icon),

      title: Text(title),

      subtitle:
          subtitle == null
              ? null
              : Text(subtitle!),

      trailing:
          trailing ??
          const Icon(Icons.chevron_right),

      onTap: onTap,
    );
  }
>>>>>>> 656d780915e823b4356a161e248a42e061f060ed
}