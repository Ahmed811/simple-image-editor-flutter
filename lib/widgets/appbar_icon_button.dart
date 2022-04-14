import 'package:flutter/material.dart';

class AppBarIconButton extends StatelessWidget {
  final VoidCallback press;
  final IconData icon;
  final Color color;
  final String tooltip;
  const AppBarIconButton(
      {Key? key,
      required this.press,
      required this.icon,
      required this.color,
      required this.tooltip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: press,
      icon: Icon(
        icon,
        color: color,
      ),
      tooltip: tooltip,
    );
  }
}
