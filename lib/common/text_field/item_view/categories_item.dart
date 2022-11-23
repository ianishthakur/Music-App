import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/common/constant/routes_strings.dart';
import 'package:music_app/common/constant/strings.dart';
import 'package:music_app/common/route/route_arguments.dart';
import 'package:music_app/common/utils/common_listview.dart';
import 'package:music_app/feature/models/music_model.dart';

class CategoriesItem extends StatelessWidget {
  CategoriesItem({super.key});

  final categoriesList = Strings.categoriesList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 14.0),
          child: Text(Strings.categories,
              style: GoogleFonts.bitter(
                  textStyle: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500))),
        ),
        Container(
          height: 44,
          width: MediaQuery.of(context).size.width,
          child: buildListView(
            item: categoriesList,
            itemBuilder: (BuildContext context, index) {
              return InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(right: 8),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFF222c33),
                  ),
                  child: Text(
                    categoriesList[index],
                    style: GoogleFonts.dancingScript(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
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
