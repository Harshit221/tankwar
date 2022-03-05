import 'dart:math';
import 'dart:ui';


import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tankwar/gameService/gamemode.dart';
import 'package:tankwar/gameService/offline.dart';
import 'package:tankwar/models/player.dart';
import 'Controllers/controller_status.dart';
import 'components/fireball/Ball.dart';
import 'components/fireball/fire_ball.dart';
import 'components/mountain_generator.dart';
import 'components/wind_display.dart';

import 'components/Tank.dart';
import 'components/game_status.dart';
import 'components/wind.dart';

class GameController extends BaseGame with TapDetector{
  final SharedPreferences storage;
  Size screenSize;
  Size playScreenSize;
  double playScreenHeightRation;
  Status gameStatus;
  double tileSize;
  List<Tank> tanks;
  bool fired;
  Ball fireBall;
  Tank tank;
  Wind wind;
  WindDisplay windDisplay;
  int turn = 0;
  Mountain mountain;
  int noOfPlayer;
  int alivePlayer;

// This is for Controller
  ControllerStatus controllerStatus;
  ControllerStatus prevControllerStatus;
  // int angle;
  // int power;
  Function updateControllerState;
  Function updateGameState;
  bool isTeleport;
  bool isShieldSelection;
  Offset teleportPosition;
  Rect rect;
  Paint paint;




//  Functions for playscreen
  Function updateScore;

//  Game Mode
  GameMode gameMode;

  GameController(this.storage, this.screenSize, String mode, List<Player> allPlayers){
    tileSize = screenSize.width / 25;
    if(mode == "Offline") {
      gameMode = new Offline(gameController: this);
    } else if(mode == "Online") {
      // Online
    }
    initiate(allPlayers);
  }

  void initiate(List<Player> allPlayer) async{
    if(gameMode is Offline) {
      gameStatus = Status.playing;
    } else {
      gameStatus = Status.playing;
    }
    playScreenHeightRation = 0.8;
    playScreenSize = Size(screenSize.width, screenSize.height*playScreenHeightRation);
    mountain = Mountain(this);
    fired = false;
    fireBall = FireBall(gameController: this, initialPosition: (Offset(-10.0,-10.0)));
    wind = Wind();
    controllerStatus = ControllerStatus.main;
    tanks = List();
    addTanks(allPlayer);

    tank = tanks[turn];
    alivePlayer = tanks.length;

  }

  void render(Canvas canvas) {
    super.render(canvas);
    gameMode.drawBackground(canvas);
    mountain.render(canvas);
    if(fired)
      fireBall.render(canvas);
    tanks.forEach((Tank tank){
      if(tank.alive)
        tank.render(canvas);
    });
    if(isTeleport == true) {
      if(teleportPosition == null)
        teleportPosition = Offset(playScreenSize.width/2,playScreenSize.height/2);
      gameMode.drawTeleportPosition(canvas);
    }
    tempRender(canvas);


  }

  void update(double t) {
    super.update(t);
    if(fired)
      fireBall.update(t);
    mountain.update(t);
    tank.update(t);
    tanks.forEach((Tank tank){
      tank.update(t);
    });
  }


  @override
  void onTapDown(TapDownDetails d) {
    gameMode.onTapDown(d);
  }

  void addTanks(List<Player> allPlayers) {
    noOfPlayer = allPlayers.length;
    for(int i=0;i<noOfPlayer;i++) {
      tanks.add(Tank(gameController: this,color: allPlayers[i].color,playerName: allPlayers[i].name));
    }
    int n = tanks.length;
    int curSize = screenSize.width ~/ n;
    Random random = Random();
    for(int i=0;i<n;i++) {
      if(i % 2 == 0) {
        int pos = random.nextInt(curSize) + curSize*i;
        tanks[i].position = mountain.points[pos];
      } else {
        int pos = random.nextInt(curSize) + curSize*(n-i);
        tanks[i].position = mountain.points[pos];
      }
    }
  }


  //temporary

  double at=0,pt=0;
  List<Offset> pts;
  Paint pt1 = Paint()..color = Colors.white..strokeWidth = 2;
  void tempRender(Canvas canvas) {
  // return;
    double angle = tank.fireDetails.angle;
    double power = tank.fireDetails.power;
    if(at != angle || pt != power) {
      pts = [];
      for(double time=0;time<10;time = time + 0.2) {
        Offset temp = getOffset(time, angle, power);
        try {
          if(temp.dy > mountain.points[temp.dx.toInt()].dy || temp.dx < 0 || temp.dx >= mountain.length)
            break;
        } catch(e) {
          break;
        }
        pts.add(temp);
      }
    }
    canvas.drawPoints(PointMode.points, pts, pt1);
  }

  Offset getOffset(double time, double angle, double power) {
    double x = tank.position.dx + tileSize * 0.5 * cos(angle) + FireBall.powerFactor * power * cos(angle) * time +
        0.04 * wind.windPower * time * time;

    double y = tank.temp - tank.imageSize.y - tileSize * 0.5 * sin(angle) - FireBall.powerFactor * power * sin(angle) * time +
        0.5 * wind.gravity * time * time;

    return Offset(x, y);
  }

}

