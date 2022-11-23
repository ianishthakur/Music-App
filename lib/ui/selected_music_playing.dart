import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../feature/models/music_model.dart';
import '../feature/models/music_player_model.dart';

class SelectedMusic extends StatefulWidget {
  SelectedMusic(
      {
      // required this.model,
      Key? key,
      required this.musicModel})
      : super(key: key);
  // Results model;
  final Results musicModel;
  @override
  State<SelectedMusic> createState() => _SelectedMusicState();
}

class _SelectedMusicState extends State<SelectedMusic> {
  late final PageManager _pageManager;

  @override
  void initState() {
    super.initState();
    _pageManager = PageManager();
  }

  @override
  void dispose() {
    _pageManager.dispose();
    super.dispose();
  }

  Color _iconColor = Color.fromARGB(255, 211, 211, 211);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF222c33),
        title: const Text(
          "Now Playing",
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(widget.musicModel.artworkUrl100.toString()),
              fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
          child: Container(
            color: Colors.black54,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 300,
                  height: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.network(
                        fit: BoxFit.fill,
                        widget.musicModel.artworkUrl100.toString()),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 270,
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        widget.musicModel.artistName.toString(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.bitter(
                          textStyle: const TextStyle(
                              color: Color.fromARGB(255, 203, 203, 203),
                              fontSize: 24,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.favorite_outlined,
                        size: 32,
                        color: Colors.redAccent,
                        // color: Color.fromARGB(255, 211, 211, 211),
                      ),
                      onPressed: () {
                        setState(() {
                          // _iconColor = Color.fromARGB(255, 211, 211, 211);
                        });
                      },
                    ),
                  ],
                ),
                Container(
                  width: 280,
                  margin: const EdgeInsets.only(
                    bottom: 18,
                  ),
                  child: Text(widget.musicModel.collectionName.toString(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.bitter(
                          textStyle: const TextStyle(
                              color: Color.fromARGB(255, 184, 184, 184),
                              fontSize: 18,
                              overflow: TextOverflow.ellipsis))),
                ),
                ValueListenableBuilder<ProgressBarState>(
                  valueListenable: _pageManager.progressNotifier,
                  builder: (_, value, __) {
                    return ProgressBar(
                      progressBarColor: Colors.white,
                      thumbRadius: 8.0,
                      timeLabelPadding: 10,
                      timeLabelTextStyle: TextStyle(color: Colors.white),

                      baseBarColor: Colors.white24,
                      thumbColor: Colors.white,

                      progress: value.current,
                      buffered: value.buffered,
                      total: value.total,
                      onSeek: _pageManager.seek,
                      // ),
                    );
                  },
                ),
                ValueListenableBuilder<ButtonState>(
                  valueListenable: _pageManager.buttonNotifier,
                  builder: (_, value, __) {
                    switch (value) {
                      case ButtonState.loading:
                        return Container(
                          width: 32.0,
                          height: 32.0,
                          child: const CircularProgressIndicator(),
                        );
                      case ButtonState.paused:
                        return IconButton(
                          icon: const Icon(
                            Icons.play_circle_fill_outlined,
                            color: Colors.white,
                          ),
                          iconSize: 68.0,
                          onPressed: _pageManager.play,
                        );
                      case ButtonState.playing:
                        return IconButton(
                          icon: const Icon(
                            Icons.pause_circle_filled_outlined,
                            color: Colors.white,
                          ),
                          iconSize: 68.0,
                          onPressed: _pageManager.pause,
                        );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
