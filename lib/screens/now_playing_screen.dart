import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/theme.dart';
import '../providers/music_provider.dart';
import '../utils/constants.dart';
import '../widgets/song_tile.dart';

class NowPlayingScreen extends StatelessWidget {
  const NowPlayingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Queue'),
        centerTitle: true,
      ),
      body: Consumer<MusicProvider>(
        builder: (context, musicProvider, _) {
          if (musicProvider.allSongs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.music_note,
                    size: 64,
                    color: AppTheme.primaryColor.withOpacity(0.5),
                  ),
                  const SizedBox(height: AppConstants.paddingLarge),
                  Text(
                    'Queue is empty',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            );
          }

          return ReorderableListView(
            onReorder: (oldIndex, newIndex) {
              // Handle reordering if needed
            },
            children: List.generate(
              musicProvider.allSongs.length,
              (index) {
                final song = musicProvider.allSongs[index];
                final isPlaying = musicProvider.currentSong?.id == song.id &&
                    musicProvider.isPlaying;
                final isCurrentIndex = index == musicProvider.currentIndex;

                return Container(
                  key: Key(song.id),
                  decoration: BoxDecoration(
                    color: isCurrentIndex
                        ? AppTheme.primaryColor.withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(
                      AppConstants.borderRadiusMedium,
                    ),
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingMedium,
                    vertical: AppConstants.paddingSmall,
                  ),
                  child: SongTile(
                    song: song,
                    isPlaying: isPlaying,
                    onTap: () {
                      musicProvider.playSong(song);
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
