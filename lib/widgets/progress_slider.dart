import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../utils/constants.dart';
import '../utils/extensions.dart';

class ProgressSlider extends StatelessWidget {
  final Duration current;
  final Duration total;
  final ValueChanged<Duration> onChanged;
  final bool isDragging;

  const ProgressSlider({
    Key? key,
    required this.current,
    required this.total,
    required this.onChanged,
    this.isDragging = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      children: [
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 4.0,
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 8.0,
              elevation: 4.0,
            ),
            overlayShape: const RoundSliderOverlayShape(
              overlayRadius: 16.0,
            ),
          ),
          child: Slider(
            value: current.inMilliseconds.toDouble(),
            min: 0.0,
            max: total.inMilliseconds.toDouble() > 0
                ? total.inMilliseconds.toDouble()
                : 1.0,
            activeColor: AppTheme.primaryColor,
            inactiveColor: isDark
                ? AppTheme.darkSecondaryTextColor.withOpacity(0.3)
                : AppTheme.secondaryTextColor.withOpacity(0.3),
            onChanged: (value) {
              onChanged(Duration(milliseconds: value.toInt()));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingMedium,
            vertical: AppConstants.paddingSmall,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                current.formatted,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Text(
                total.formatted,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
