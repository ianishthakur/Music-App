import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:music_app/common/route/route_generator.dart';
import 'package:music_app/feature/models/music_model.dart';

import '../common/constant/assets.dart';
import '../common/constant/routes_strings.dart';
import '../common/constant/strings.dart';
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
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;
  List<Results> data = [];

  @override
  void initState() {
    getConnectivity();
    getData();
    super.initState();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

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
                            child: Text(Strings.hello + widget.username,
                                style: GoogleFonts.bitter(
                                    textStyle: const TextStyle(
                                        fontSize: 14, color: Colors.grey))),
                          ),
                          Container(
                            width: 200,
                            child: Text(widget.useremail,
                                style: GoogleFonts.bitter(
                                    textStyle: const TextStyle(
                                        fontSize: 18, color: Colors.white))),
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
                
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
                child: Text(
                  Strings.music,
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
  showDialogBox() => showCupertinoDialog<Strings>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text(Strings.noConnection),
          content: const Text(Strings.checkUrInternet),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text(Strings.ok),
            ),
          ],
        ),
      );
}
