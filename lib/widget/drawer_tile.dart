import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final Text title;
  final Color iconColor;
  final VoidCallback onTap;
  final Widget? trailling;

  const DrawerTile({
    this.trailling,
    required this.onTap,
    required this.icon,
    required this.iconColor,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      iconColor: iconColor,
      titleAlignment: ListTileTitleAlignment.center,
      title: title,
      leading: Icon(icon),
      onTap: onTap,
      trailing: trailling,
    );
  }
}
