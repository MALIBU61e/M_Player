import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import '../models/song.dart';

class AudioService {
  late AudioPlayer _audioPlayer;
  
  AudioService() {
    _audioPlayer = AudioPlayer();
    _initAudioSession();
  }

  AudioPlayer get player => _audioPlayer;

  Future<void> _initAudioSession() async {
    try {
      final session = await AudioSession.instance;
      await session.configure(const AudioSessionConfiguration.music());
    } catch (e) {
      print('Error configuring audio session: $e');
    }
  }

  Future<void> loadSong(Song song) async {
    try {
      if (song.filePath != null) {
        await _audioPlayer.setFilePath(song.filePath!);
      }
    } catch (e) {
      print('Error loading song: $e');
      rethrow;
    }
  }

  Future<void> play() async {
    try {
      await _audioPlayer.play();
    } catch (e) {
      print('Error playing: $e');
    }
  }

  Future<void> pause() async {
    try {
      await _audioPlayer.pause();
    } catch (e) {
      print('Error pausing: $e');
    }
  }

  Future<void> stop() async {
    try {
      await _audioPlayer.stop();
    } catch (e) {
      print('Error stopping: $e');
    }
  }

  Future<void> seek(Duration position) async {
    try {
      await _audioPlayer.seek(position);
    } catch (e) {
      print('Error seeking: $e');
    }
  }

  Future<void> setPlaybackRate(double rate) async {
    try {
      await _audioPlayer.setPlaybackRate(rate);
    } catch (e) {
      print('Error setting playback rate: $e');
    }
  }

  Stream<Duration> get positionStream => _audioPlayer.positionStream;
  Stream<Duration?> get durationStream => _audioPlayer.durationStream;
  Stream<PlayerState> get playerStateStream => _audioPlayer.playerStateStream;
  Stream<bool> get playingStream => _audioPlayer.playingStream;

  Duration get currentPosition => _audioPlayer.position;
  Duration? get duration => _audioPlayer.duration;
  bool get isPlaying => _audioPlayer.playing;

  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}
