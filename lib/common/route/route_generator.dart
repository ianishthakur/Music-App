import 'package:flutter/material.dart';
import 'package:music_app/common/constant/routes_strings.dart';
import 'package:music_app/common/route/route_arguments.dart';
import 'package:music_app/feature/models/music_model.dart';
import 'package:music_app/ui/home_page.dart';
import 'package:music_app/ui/landing_page.dart';
import 'package:music_app/ui/selected_music_playing.dart';

import '../../ui/register_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case RoutesStrings.landingPage:
        return MaterialPageRoute(builder: (_) => LandingPage());
      case RoutesStrings.homePage:
        var typedArgs = args as NavProps;
        return MaterialPageRoute(
            builder: (_) => HomePage(
                  useremail: typedArgs.email,
                  username: typedArgs.name,
                ));
      case RoutesStrings.selectedMusicPlaying:
      var typedMusicArgs = args as MusicArguments;
        return MaterialPageRoute(builder: (_) => SelectedMusic(musicModel: typedMusicArgs.musicModel));
      case RoutesStrings.registerPage:
        return MaterialPageRoute(builder: (_) => RegisterPage());

      default:
        return MaterialPageRoute(builder: (_) => LandingPage());
    }
  }
}
