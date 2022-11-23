import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/common/constant/strings.dart';
import 'package:music_app/common/utils/common_listview.dart';
import 'package:music_app/feature/models/music_model.dart';

import '../../constant/assets.dart';
import '../../constant/routes_strings.dart';
import '../../route/route_arguments.dart';

class RecentlyItem extends StatelessWidget {
  RecentlyItem({super.key, required this.item});
  final List<Results> item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: 24.0, bottom: 10),
            child: Text(
              Strings.recentlyPlayed,
              style: GoogleFonts.bitter(
                  textStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            ),
          ),
        ),
        Container(
          // color: Colors.red,
          height: MediaQuery.of(context).size.height * 0.37,
          width: MediaQuery.of(context).size.width * 0.9,
          child: buildListView(
            scrollDirection: Axis.vertical,
            item: item,
            itemBuilder: (BuildContext context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                      context, RoutesStrings.selectedMusicPlaying,
                      arguments: MusicArguments(musicModel: item[index]));
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Color(0xFF222c33)),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20)),
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                          image: NetworkImage(
                              item[index].artworkUrl100.toString()),
                          fit: BoxFit.fill,
                          errorBuilder:(BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  if (exception is SocketException) {
                    return Image.asset(Assets.placeholder);
                  }
                  return Text(exception.toString());

                
                },
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6.0, vertical: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  child: Text(item[index].artistName.toString(),
                                      style: GoogleFonts.bitter(
                                          textStyle: const TextStyle(
                                              color: Color(0xFF222c33),
                                              fontSize: 18,
                                              overflow:
                                                  TextOverflow.ellipsis)))),
                              Container(
                                  child: Text(
                                      item[index].collectionName.toString(),
                                      style: GoogleFonts.bitter(
                                          textStyle: const TextStyle(
                                              color: Color(0xFF222c33),
                                              fontSize: 14,
                                              overflow:
                                                  TextOverflow.ellipsis))))
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: const Icon(
                          Icons.play_circle_fill_outlined,
                          color: Colors.black,
                          size: 54,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
