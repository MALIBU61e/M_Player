import 'song.dart';

class Playlist {
  final String id;
  final String name;
  final String? description;
  final List<Song> songs;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? coverUrl;

  Playlist({
    required this.id,
    required this.name,
    this.description,
    required this.songs,
    required this.createdAt,
    this.updatedAt,
    this.coverUrl,
  });

  int get songCount => songs.length;

  Duration get totalDuration {
    return Duration(
      milliseconds: songs.fold<int>(
        0,
        (prev, song) => prev + song.duration.inMilliseconds,
      ),
    );
  }

  void addSong(Song song) {
    if (!songs.contains(song)) {
      songs.add(song);
    }
  }

  void removeSong(Song song) {
    songs.remove(song);
  }

  void removeSongAt(int index) {
    if (index >= 0 && index < songs.length) {
      songs.removeAt(index);
    }
  }

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['id'] ?? '',
      name: json['name'] ?? 'New Playlist',
      description: json['description'],
      songs: List<Song>.from(
        (json['songs'] as List?)?.map((song) => Song.fromJson(song)) ?? [],
      ),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      coverUrl: json['coverUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'songs': songs.map((song) => song.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'coverUrl': coverUrl,
    };
  }
}
