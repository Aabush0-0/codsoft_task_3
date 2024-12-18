import 'package:flutter/material.dart';
import 'package:music_app/components/my_drawer.dart';
import 'package:music_app/models/playlist_provider.dart';
import 'package:music_app/models/song.dart';
import 'package:music_app/pages/song_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //get playlist provider
  late final dynamic playlistProvider;

  @override
  void initState() {
    super.initState();

    //playlist provider
    playlistProvider = Provider.of<PlaylistProvider>(
      context,
      listen: false,
    );
  }

  void goToSong(int songIndex) {
    //update current song
    playlistProvider.currentSongIndex = songIndex;

    //navigate to song page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SongPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('P L A Y L I S T'),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: Consumer<PlaylistProvider>(builder: (context, value, child) {
        //get playlist
        final List<Song> playlist = value.playlist;

        //return listview UI
        return ListView.builder(
          itemCount: playlist.length,
          itemBuilder: (context, index) {
            //get solo song
            final Song song = playlist[index];

            //return listtile UI
            return ListTile(
              title: Text(song.songName),
              subtitle: Text(song.artistName),
              leading: Image.asset(song.albumArtPath),
              onTap: () {
                goToSong(index);
              },
            );
          },
        );
      }),
    );
  }
}
