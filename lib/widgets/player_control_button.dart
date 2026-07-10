import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../utils/constants.dart';

class PlayerControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final double size;
  final bool isActive;

  const PlayerControlButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.color,
    this.size = AppConstants.iconSizeLarge,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
        child: Container(
          padding: const EdgeInsets.all(AppConstants.paddingSmall),
          child: Icon(
            icon,
            size: size,
            color: isActive ? (color ?? AppTheme.primaryColor) : (color ?? Colors.grey),
          ),
        ),
      ),
    );
  }
}
