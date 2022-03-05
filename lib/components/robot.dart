import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tankwar/components/Tank.dart';
import 'package:tankwar/components/fireball/fire_ball.dart';
import 'package:tankwar/game_controller.dart';

class Robot {
  final GameController gameController;
  List<bool> selected;
  Tank get _tank => gameController.tank;
  List<Tank> get _tanks => gameController.tanks;

  Robot(this.gameController);


  void play() {
    print('play called');

    //for testing only:: remove after complete
    _tanks.forEach((element) {
      element.health = double.maxFinite;
      element.accessories.weapons[0].quantity = 100;
    });

    selected = List<bool>.filled(_tanks.length, false, growable: false);
    selected[_tanks.indexOf(_tank)] = true;
    int count = 1;
    int index;
    // while(count < _tanks.length) {
    //   index = _closestTank();
    //   if(index<0)
    //     continue;
    //   _calculate(index);
    //   count++;
    // }

    index = _closestTank();
    _calculate(index);
  }

  void _calculate(int index) {
    print('calculate called');
    for(double time=0; time<10; time=time+0.2) {

      double x = _tanks[index].position.dx - _tank.position.dx - 0.04 * gameController.wind.windPower * time * time;
      double y = _tank.temp - _tank.imageSize.y - _tanks[index].temp + 0.5 * gameController.wind.gravity * time * time;
      // double a1 = atan(x/-y);
      double angle = atan2(y, x);
      if(angle < 0)
        continue;
      double power = (x / cos(angle) - _tank.tileSize * 0.5) / (time * FireBall.powerFactor);

      if(power < 0 || power > 100) {
        continue;
      }

      print('Angle: ${angle*180/pi} Power: $power');

    }
  }

  int _closestTank() {
    double distance = double.minPositive;
    int index=-1;
    for(int i=0; i<_tanks.length; i++) {
      if(selected[i])
        continue;
      double temp = (Offset(_tank.position.dx, _tank.temp) - _tanks[i].position).distance;
      if(temp < distance) {
        distance = temp;
        index = i;
      }
    }
    if(index != -1)
      selected[index] = true;
    return index;
  }
}