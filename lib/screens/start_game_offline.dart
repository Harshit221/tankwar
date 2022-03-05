import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tankwar/game_controller.dart';
import 'package:tankwar/models/player.dart';
import 'package:tankwar/screens/main_screen.dart';
import 'package:tankwar/screens/screen_controller.dart';

class StartGameOffline extends StatefulWidget {
  final List<Player> allPlayer;
  final SharedPreferences sharedPreferences;
  final Size size;
  final String mode;

  StartGameOffline(
      {Key key, this.allPlayer, this.sharedPreferences, this.size, this.mode})
      : super(key: key);

  @override
  _StartGameOfflineState createState() => _StartGameOfflineState();
}

class _StartGameOfflineState extends State<StartGameOffline> {


  GameController gameController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
          onWillPop: () async => false,
          child: ScreenController(
            gameController: gameController,
          )),
    );
  }

  void loadPlayers() {
    print('size -----> ${widget.size}');
    gameController = new GameController(
        widget.sharedPreferences, widget.size, widget.mode, widget.allPlayer);
  }
}
