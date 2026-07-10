import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../models/song.dart';
import '../models/playlist.dart';
import '../services/audio_service.dart';

class MusicProvider extends ChangeNotifier {
  final AudioService _audioService;
  
  List<Song> _allSongs = [];
  List<Playlist> _playlists = [];
  Song? _currentSong;
  int _currentIndex = 0;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isRepeatOne = false;
  bool _isShuffle = false;

  MusicProvider(this._audioService) {
    _initializeAudioListeners();
  }

  // Getters
  List<Song> get allSongs => _allSongs;
  List<Playlist> get playlists => _playlists;
  Song? get currentSong => _currentSong;
  int get currentIndex => _currentIndex;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isPlaying => _audioService.isPlaying;
  bool get isRepeatOne => _isRepeatOne;
  bool get isShuffle => _isShuffle;
  Duration get currentPosition => _audioService.currentPosition;
  Duration? get duration => _audioService.duration;

  void _initializeAudioListeners() {
    _audioService.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        next();
      }
      notifyListeners();
    });
  }

  Future<void> loadSongs(List<Song> songs) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      _allSongs = songs;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> playSong(Song song) async {
    try {
      _errorMessage = null;
      _currentSong = song;
      _currentIndex = _allSongs.indexOf(song);
      await _audioService.loadSong(song);
      await _audioService.play();
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error playing song: $e';
      notifyListeners();
    }
  }

  Future<void> playPlaylist(Playlist playlist, {int startIndex = 0}) async {
    try {
      _errorMessage = null;
      _allSongs = playlist.songs;
      if (startIndex >= 0 && startIndex < playlist.songs.length) {
        _currentIndex = startIndex;
        _currentSong = playlist.songs[startIndex];
        await _audioService.loadSong(_currentSong!);
        await _audioService.play();
      }
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error playing playlist: $e';
      notifyListeners();
    }
  }

  Future<void> play() async {
    try {
      await _audioService.play();
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error playing: $e';
      notifyListeners();
    }
  }

  Future<void> pause() async {
    try {
      await _audioService.pause();
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error pausing: $e';
      notifyListeners();
    }
  }

  Future<void> next() async {
    try {
      _errorMessage = null;
      if (_allSongs.isEmpty) return;

      if (_isRepeatOne) {
        await _audioService.seek(Duration.zero);
        await _audioService.play();
      } else {
        _currentIndex = (_currentIndex + 1) % _allSongs.length;
        _currentSong = _allSongs[_currentIndex];
        await _audioService.loadSong(_currentSong!);
        await _audioService.play();
      }
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error going to next song: $e';
      notifyListeners();
    }
  }

  Future<void> previous() async {
    try {
      _errorMessage = null;
      if (_allSongs.isEmpty) return;

      if (currentPosition.inSeconds > 3) {
        await _audioService.seek(Duration.zero);
        await _audioService.play();
      } else {
        _currentIndex = (_currentIndex - 1) < 0 ? _allSongs.length - 1 : _currentIndex - 1;
        _currentSong = _allSongs[_currentIndex];
        await _audioService.loadSong(_currentSong!);
        await _audioService.play();
      }
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error going to previous song: $e';
      notifyListeners();
    }
  }

  Future<void> seek(Duration position) async {
    try {
      await _audioService.seek(position);
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error seeking: $e';
      notifyListeners();
    }
  }

  void toggleRepeat() {
    _isRepeatOne = !_isRepeatOne;
    notifyListeners();
  }

  void toggleShuffle() {
    _isShuffle = !_isShuffle;
    if (_isShuffle) {
      _allSongs.shuffle();
      _currentIndex = 0;
    }
    notifyListeners();
  }

  void addPlaylist(Playlist playlist) {
    _playlists.add(playlist);
    notifyListeners();
  }

  void removePlaylist(Playlist playlist) {
    _playlists.remove(playlist);
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _audioService.dispose();
    super.dispose();
  }
}
