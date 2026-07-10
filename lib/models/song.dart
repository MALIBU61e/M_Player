class Song {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String? coverUrl;
  final Duration duration;
  final String? filePath;
  final DateTime? dateAdded;
  final int? size;
  final String? genre;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    this.coverUrl,
    required this.duration,
    this.filePath,
    this.dateAdded,
    this.size,
    this.genre,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'] ?? '',
      title: json['title'] ?? 'Unknown',
      artist: json['artist'] ?? 'Unknown Artist',
      album: json['album'] ?? 'Unknown Album',
      coverUrl: json['coverUrl'],
      duration: Duration(milliseconds: json['duration'] ?? 0),
      filePath: json['filePath'],
      dateAdded: json['dateAdded'] != null ? DateTime.parse(json['dateAdded']) : null,
      size: json['size'],
      genre: json['genre'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'album': album,
      'coverUrl': coverUrl,
      'duration': duration.inMilliseconds,
      'filePath': filePath,
      'dateAdded': dateAdded?.toIso8601String(),
      'size': size,
      'genre': genre,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Song &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
