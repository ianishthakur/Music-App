import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/common/utils/common_listview.dart';
import 'package:music_app/feature/models/music_model.dart';
import 'package:music_app/feature/services/music_services.dart';

import '../../constant/assets.dart';
import '../../constant/routes_strings.dart';
import '../../constant/strings.dart';
import '../../route/route_arguments.dart';

class PlayListItem extends StatelessWidget {
  const PlayListItem({
    super.key,
    required this.item,
    required this.musicname,
    required this.songname,
  });

  final String musicname;

  final String songname;
  final List<Results> item;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Strings.playlists,
                style: GoogleFonts.bitter(
                    textStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
              ),
              const Icon(
                Icons.arrow_forward,
                color: Colors.grey,
                size: 24,
              )
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            height: 150.0,
            width: MediaQuery.of(context).size.width * 0.89,
            child: buildListView(
              item: item,
              itemBuilder: (BuildContext context, index) {
                return Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, RoutesStrings.selectedMusicPlaying,
                            arguments: MusicArguments(musicModel: item[index]));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(
                            image: NetworkImage(
                                item[index].artworkUrl100.toString()),
                            fit: BoxFit.fill,
                            width: 140,
                            errorBuilder:(BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  if (exception is SocketException) {
                    return Image.asset(Assets.placeholder);
                  }
                  return Text(exception.toString());

                
                },
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 60, 43, 90)
                                  .withOpacity(0.5),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                              top: 6.0, left: 10),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              1 /
                                              34,
                                          width: 90,
                                          child: Text(
                                            item[index].artistName.toString(),
                                            style: GoogleFonts.bitter(
                                              textStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          height: 20,
                                          width: 90,
                                          child: Text(
                                            item[index]
                                                .collectionName
                                                .toString(),
                                            style: GoogleFonts.bitter(
                                              textStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(right: 2),
                                      child: const Icon(
                                        Icons.play_circle_fill_outlined,
                                        color: Colors.white,
                                        size: 36,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
