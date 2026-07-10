import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/theme.dart';
import '../providers/music_provider.dart';
import '../utils/constants.dart';
import '../utils/extensions.dart';
import '../widgets/player_control_button.dart';
import '../widgets/progress_slider.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MusicProvider>(
      builder: (context, musicProvider, _) {
        final song = musicProvider.currentSong;

        if (song == null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Player'),
            ),
            body: const Center(
              child: Text('No song playing'),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Now Playing'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: AppConstants.paddingXLarge),
                // Album Art
                Hero(
                  tag: song.id,
                  child: Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(
                        AppConstants.borderRadiusXLarge,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.music_note,
                      size: 120,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.paddingXLarge),
                // Song Info
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingLarge,
                  ),
                  child: Column(
                    children: [
                      Text(
                        song.title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: AppConstants.paddingSmall),
                      Text(
                        song.artist,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppTheme.secondaryTextColor,
                            ),
                      ),
                      const SizedBox(height: AppConstants.paddingSmall),
                      Text(
                        song.album,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppConstants.paddingXLarge),
                // Progress Slider
                StreamBuilder<Duration>(
                  stream: musicProvider._audioService.positionStream,
                  initialData: Duration.zero,
                  builder: (context, snapshot) {
                    return ProgressSlider(
                      current: snapshot.data ?? Duration.zero,
                      total: musicProvider.duration ?? Duration.zero,
                      onChanged: (duration) {
                        musicProvider.seek(duration);
                      },
                    );
                  },
                ),
                const SizedBox(height: AppConstants.paddingLarge),
                // Control Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingLarge,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      PlayerControlButton(
                        icon: Icons.shuffle,
                        onPressed: musicProvider.toggleShuffle,
                        isActive: musicProvider.isShuffle,
                      ),
                      PlayerControlButton(
                        icon: Icons.skip_previous,
                        onPressed: musicProvider.previous,
                        size: AppConstants.iconSizeXLarge,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppTheme.primaryColor,
                              AppTheme.accentColor,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.primaryColor.withOpacity(0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: musicProvider.isPlaying
                                ? musicProvider.pause
                                : musicProvider.play,
                            borderRadius: BorderRadius.circular(60),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                AppConstants.paddingLarge,
                              ),
                              child: Icon(
                                musicProvider.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      PlayerControlButton(
                        icon: Icons.skip_next,
                        onPressed: musicProvider.next,
                        size: AppConstants.iconSizeXLarge,
                      ),
                      PlayerControlButton(
                        icon: musicProvider.isRepeatOne
                            ? Icons.repeat_one
                            : Icons.repeat,
                        onPressed: musicProvider.toggleRepeat,
                        isActive: musicProvider.isRepeatOne,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppConstants.paddingXLarge),
                // Playlist Info
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingLarge,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Playlist',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        '${musicProvider.currentIndex + 1}/${musicProvider.allSongs.length}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppConstants.paddingMedium),
              ],
            ),
          ),
        );
      },
    );
  }
}
