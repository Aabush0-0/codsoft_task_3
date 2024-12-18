import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/models/song.dart';

//enum to define repeat modes
enum RepeatMode { noRepeat, repeatOne, repeatAll }

class PlaylistProvider extends ChangeNotifier {
  //playlist
  final List<Song> _playlist = [
    //1
    Song(
        songName: 'Dazed and Confused',
        artistName: "Led Zeppelin",
        albumArtPath: "assets/images/lz.png",
        audioPath: "audio/dazedandconfused.mp3"),

    //2
    Song(
        songName: "God",
        artistName: "Kendrick Lamar",
        albumArtPath: "assets/images/damn.jpg",
        audioPath: 'audio/god.mp3'),

    //3
    Song(
        songName: 'Fear',
        artistName: "Kendrick Lamar",
        albumArtPath: "assets/images/damn.jpg",
        audioPath: 'audio/fear.mp3'),

    //4
    Song(
        songName: 'Hatesong',
        artistName: "Porcupine Tree",
        albumArtPath: "assets/images/pt.png",
        audioPath: 'audio/hatesong.mp3'),

    //5
    Song(
        songName: 'Righteous',
        artistName: "Juice WRLD",
        albumArtPath: "assets/images/juice.png",
        audioPath: 'audio/righteous.mp3'),
  ];

  //current song playing
  int? _currentSongIndex;

  //audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

//duration
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  //constructor
  PlaylistProvider() {
    listenToDuration();
  }

  //initial player
  bool _isPlaying = false;

  //play
  void play() async {
    final String path = _playlist[currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  //pause
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  //resume
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  //pause or resume
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  //seeking specific position
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  //play next
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        currentSongIndex = 0;
      }
    }
  }

//play previous
  void playPreviousSong() async {
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  //shuffle
  void shuffleSong() {
    _playlist.shuffle(Random());
    return play();
  }

  //listen to duration
  void listenToDuration() {
    //listening total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    //listening current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    //listening for song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  //disposing audio player

  @override
  void dispose() {
    _audioPlayer.dispose(); //disposing player when not used
    super.dispose();
  }

  //getters
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  //setters

  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;

    if (newIndex != null) {
      play();
    }

    //update UI
    notifyListeners();
  }
}
