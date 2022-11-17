import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

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
              children: [
                // Image(
                //   height: 280,
                //   fit: BoxFit.contain,
                //   width: double.infinity,
                //   image: NetworkImage(
                //     widget.model.artworkUrl100.toString(),
                //   ),
                // ),
                // SizedBox(height: 10),
                // Text(
                //   widget.model.artistName.toString(),
                //   style: TextStyle(
                //       fontSize: 20,
                //       fontWeight: FontWeight.w700,
                //       color: Colors.white54),
                // ),
                // SizedBox(height: 4),
                // Text(
                //   widget.model.trackName.toString(),
                //   style: TextStyle(color: Colors.white54),
                // ),
                const Spacer(),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
