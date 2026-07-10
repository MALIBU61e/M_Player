import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../config/theme.dart';
import '../models/song.dart';
import '../utils/constants.dart';
import '../utils/extensions.dart';

class SongTile extends StatelessWidget {
  final Song song;
  final bool isPlaying;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const SongTile({
    Key? key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingMedium,
            vertical: AppConstants.paddingSmall,
          ),
          decoration: BoxDecoration(
            color: isPlaying
                ? (isDark ? AppTheme.darkSurfaceColor : AppTheme.surfaceColor)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
          ),
          child: Row(
            children: [
              // Cover Image
              ClipRRect(
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
                child: Container(
                  width: 56,
                  height: 56,
                  color: isDark ? AppTheme.darkSurfaceColor : AppTheme.surfaceColor,
                  child: song.coverUrl != null && song.coverUrl!.isValidUrl
                      ? CachedNetworkImage(
                          imageUrl: song.coverUrl!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: isDark
                                ? AppTheme.darkSurfaceColor
                                : AppTheme.surfaceColor,
                            child: const Icon(Icons.music_note),
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.music_note),
                        )
                      : const Icon(Icons.music_note),
                ),
              ),
              const SizedBox(width: AppConstants.paddingMedium),
              // Song Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      song.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: isPlaying ? FontWeight.w600 : FontWeight.w500,
                            color: isPlaying ? AppTheme.primaryColor : null,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      song.artist,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppConstants.paddingSmall),
              // Duration
              Text(
                song.duration.formatted,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              if (isPlaying)
                Padding(
                  padding: const EdgeInsets.only(left: AppConstants.paddingMedium),
                  child: Icon(
                    Icons.play_arrow,
                    color: AppTheme.primaryColor,
                    size: AppConstants.iconSizeMedium,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
