import 'package:intl/intl.dart';

extension DurationExtension on Duration {
  String get formatted {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);

    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String get formattedHMS {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);

    List<String> parts = [];
    if (hours > 0) parts.add('$hours h');
    if (minutes > 0) parts.add('$minutes min');
    if (seconds > 0 || parts.isEmpty) parts.add('$seconds sec');

    return parts.join(' ');
  }
}

extension DateTimeExtension on DateTime {
  String get formatted {
    return DateFormat('MMM dd, yyyy').format(this);
  }

  String get formattedTime {
    return DateFormat('hh:mm a').format(this);
  }

  String get formattedFull {
    return DateFormat('MMM dd, yyyy - hh:mm a').format(this);
  }
}

extension StringExtension on String {
  bool get isValidUrl {
    try {
      Uri.parse(this);
      return true;
    } catch (e) {
      return false;
    }
  }

  String get capitalize {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  String get capitalizeEachWord {
    return split(' ')
        .map((word) => word.isEmpty ? word : word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }

  String get truncate {
    if (length <= 30) return this;
    return '${substring(0, 30)}...';
  }
}

extension IntExtension on int {
  String get toFormattedString {
    if (this >= 1000000) {
      return '${(this / 1000000).toStringAsFixed(1)}M';
    } else if (this >= 1000) {
      return '${(this / 1000).toStringAsFixed(1)}K';
    }
    return toString();
  }
}
