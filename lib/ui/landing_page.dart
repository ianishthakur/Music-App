import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/common/constant/routes_strings.dart';

import '../common/constant/assets.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.loose,
          children: [
            Container(
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  Assets.bokeh,
                  fit: BoxFit.fitHeight,
                )),
            Positioned(
              height: MediaQuery.of(context).size.height / 1 / 3,
              top: 30,
              left: 10,
              right: 10,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      Assets.musician,
                      fit: BoxFit.fill,
                    )),
              ),
            ),
            Positioned(
              height: MediaQuery.of(context).size.height / 2,
              left: 10,
              right: 10,
              bottom: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 1 / 4,
                          width: double.infinity,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  Assets.hand,
                                  fit: BoxFit.fill,
                                )),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 50,
                            width: 300,
                            child: Text(
                              "Discover Music",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bitter(
                                  textStyle: const TextStyle(
                                      color: Colors.white, fontSize: 28)),
                            )),
                        Container(
                            height: 70,
                            width: 320,
                            child: Text(
                              "Like Never Before",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.greatVibes(
                                  textStyle: const TextStyle(
                                      color: Colors.white, fontSize: 48)),
                            )),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutesStrings.registerPage);
                          },
                          child: Container(
                              height: 48,
                              width: 300,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Colors.white,
                                      Colors.transparent,
                                      Colors.white,
                                    ],
                                  )),
                              child: Center(
                                child: Text(
                                  "Discover",
                                  style: GoogleFonts.greatVibes(
                                      textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 34,
                                          fontWeight: FontWeight.bold)),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
