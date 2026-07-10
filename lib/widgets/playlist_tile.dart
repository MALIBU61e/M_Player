import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../models/playlist.dart';
import '../utils/constants.dart';

class PlaylistTile extends StatelessWidget {
  final Playlist playlist;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const PlaylistTile({
    Key? key,
    required this.playlist,
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
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
        child: Container(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          decoration: BoxDecoration(
            color: isDark ? AppTheme.darkSurfaceColor : AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
                ),
                child: Icon(
                  Icons.playlist_play,
                  size: AppConstants.iconSizeXLarge,
                  color: AppTheme.primaryColor,
                ),
              ),
              const SizedBox(height: AppConstants.paddingMedium),
              Text(
                playlist.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppConstants.paddingSmall),
              Text(
                '${playlist.songCount} songs',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
