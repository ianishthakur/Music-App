import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/common/route/route_generator.dart';
import 'package:music_app/feature/models/music_model.dart';

import '../common/constant/assets.dart';
import '../common/constant/routes_strings.dart';
import '../common/text_field/item_view/categories_item.dart';
import '../common/text_field/item_view/playlists_item.dart';
import '../common/text_field/item_view/recently_item.dart';
import '../feature/services/music_services.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesStrings.landingPage,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.username, required this.useremail});
  final String username;
  final String useremail;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Results> data = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future getData() async {
    var datas = await MusicServices().getData();
    setState(() {
      data = datas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Color(0xFF222c33),
          // Color.fromARGB(255, 235, 230, 244),
          // Color.fromARGB(255, 235, 230, 244),
          elevation: 0,
          automaticallyImplyLeading: false,
          leadingWidth: 0,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 30, left: 10),
                child: Row(
                  children: [
                    CircleAvatar(
                      child: Image.asset(Assets.profile),
                    ),
                    SizedBox(width: 10),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            width: 200,
                            child: Text(
                              ("Hello, ") + widget.username,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ),
                          Container(
                            width: 200,
                            child: Text(
                              widget.useremail,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            Container(
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(
                Icons.notifications_outlined,
                color: Colors.white,
                size: 28,
              ),
            )
          ],
        ),
        body: Container(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 6,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Color(0xFF222c33),
                    // color: Color.fromARGB(255, 235, 230, 244),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
                child: Text(
                  "Music",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.greatVibes(
                    textStyle: TextStyle(color: Colors.white, fontSize: 38),
                  ),
                ),
              ),
              ListView(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    margin: EdgeInsets.only(top: 50),
                    child: Positioned(
                        child: Column(
                      children: [
                        PlayListItem(
                          item: data,
                          musicname: '',
                          songname: '',
                        ),
                        CategoriesItem(),
                        RecentlyItem(
                          item: data,
                        ),
                      ],
                    )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
