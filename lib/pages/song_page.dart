import 'package:flutter/material.dart';
import 'package:music_app/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  //convert duration time
  String formatTime(Duration duration) {
    String twoDigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(builder: (context, value, child) {
      //get playlist
      final playlist = value.playlist;

      //get current song
      final currentSong = playlist[value.currentSongIndex ?? 0];

      //return scaffold UI
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
              bottom: 25,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //appbar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const Text('S O N G     P L A Y I N G'),

                    //menu
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.menu,
                      ),
                    ),
                  ],
                ),
                //album artwork
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).colorScheme.background,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade800,
                        blurRadius: 15,
                        offset: const Offset(4, 4),
                      ),
                      const BoxShadow(
                        color: Colors.white,
                        blurRadius: 15,
                        offset: Offset(-4, -4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(1),
                        child: Image.asset(
                          currentSong.albumArtPath,
                          scale: 0.1,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //song and artist name and icon
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentSong.songName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(currentSong.artistName)
                            ],
                          ),
                          //heart icon
                          const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //song duration
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //start time
                          Text(formatTime(value.currentDuration)),
                          //shuffle icon
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                value.shuffleSong();
                              },
                              child: const Icon(Icons.shuffle),
                            ),
                          ),

                          //repeat icon

                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: const Icon(Icons.repeat),
                            ),
                          ),

                          //end time
                          Text(formatTime(value.totalDuration)),
                        ],
                      ),
                    ],
                  ),
                ),

                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 6),
                  ),
                  child: Slider(
                    min: 0,
                    max: value.totalDuration.inSeconds.toDouble(),
                    value: value.currentDuration.inSeconds.toDouble(),
                    activeColor: Colors.red,
                    onChanged: (double double) {
                      //during sliding
                    },
                    onChangeEnd: (double double) {
                      //during sliding completed
                      value.seek(Duration(seconds: double.toInt()));
                    },
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),
                //playback ctrls

                Row(
                  children: [
                    //skip
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          value.playPreviousSong();
                        },
                        child: const Card(
                          child: Icon(Icons.skip_previous),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    //play
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          value.pauseOrResume();
                        },
                        child: Card(
                          child: Icon(value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow_rounded),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    //skip
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          value.playNextSong();
                        },
                        child: const Card(
                          child: Icon(Icons.skip_next),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
