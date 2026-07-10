import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/theme.dart';
import '../models/song.dart';
import '../models/playlist.dart';
import '../providers/music_provider.dart';
import '../utils/constants.dart';
import '../widgets/song_tile.dart';
import '../widgets/playlist_tile.dart';
import 'player_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadSongs();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadSongs() {
    // Sample data - Replace with actual music loading
    final sampleSongs = [
      Song(
        id: '1',
        title: 'Summer Vibes',
        artist: 'The Band',
        album: 'Happy Days',
        duration: const Duration(minutes: 3, seconds: 45),
        filePath: null,
      ),
      Song(
        id: '2',
        title: 'Night Drive',
        artist: 'Neon Dreams',
        album: 'Synthwave',
        duration: const Duration(minutes: 4, seconds: 12),
        filePath: null,
      ),
      Song(
        id: '3',
        title: 'Electric Soul',
        artist: 'Modern Grooves',
        album: 'Future Beats',
        duration: const Duration(minutes: 3, seconds: 58),
        filePath: null,
      ),
    ];

    Future.microtask(() {
      context.read<MusicProvider>().loadSongs(sampleSongs);
    });
  }

  void _showAddPlaylistDialog() {
    final textController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Playlist'),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
            hintText: 'Playlist name',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (textController.text.isNotEmpty) {
                final playlist = Playlist(
                  id: DateTime.now().toString(),
                  name: textController.text,
                  songs: [],
                  createdAt: DateTime.now(),
                );
                context.read<MusicProvider>().addPlaylist(playlist);
                Navigator.pop(context);
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppConstants.appName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: AppConstants.fontSizeXLarge,
          ),
        ),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.primaryColor,
          tabs: const [
            Tab(text: 'Songs'),
            Tab(text: 'Playlists'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSongsTab(),
          _buildPlaylistsTab(),
        ],
      ),
      floatingActionButton: _tabController.index == 1
          ? FloatingActionButton(
              onPressed: _showAddPlaylistDialog,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildSongsTab() {
    return Consumer<MusicProvider>(
      builder: (context, musicProvider, _) {
        if (musicProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

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
                  AppConstants.noSongsMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          itemCount: musicProvider.allSongs.length,
          itemBuilder: (context, index) {
            final song = musicProvider.allSongs[index];
            final isPlaying = musicProvider.currentSong?.id == song.id &&
                musicProvider.isPlaying;

            return SongTile(
              song: song,
              isPlaying: isPlaying,
              onTap: () {
                musicProvider.playSong(song);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PlayerScreen(),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildPlaylistsTab() {
    return Consumer<MusicProvider>(
      builder: (context, musicProvider, _) {
        if (musicProvider.playlists.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.playlist_play,
                  size: 64,
                  color: AppTheme.primaryColor.withOpacity(0.5),
                ),
                const SizedBox(height: AppConstants.paddingLarge),
                Text(
                  AppConstants.noPlaylistsMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: AppConstants.paddingMedium,
            crossAxisSpacing: AppConstants.paddingMedium,
          ),
          itemCount: musicProvider.playlists.length,
          itemBuilder: (context, index) {
            final playlist = musicProvider.playlists[index];

            return PlaylistTile(
              playlist: playlist,
              onTap: () {
                if (playlist.songs.isNotEmpty) {
                  musicProvider.playPlaylist(playlist);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PlayerScreen(),
                    ),
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}
