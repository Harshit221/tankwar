import 'package:flutter/material.dart';
import 'package:tankwar/Shield/shield.dart';

class WeakShield extends ShieldDetails{
  WeakShield() {
    super.maxHealth = 100;
    super.color = Colors.brown;
    super.curHealth = maxHealth;
//    super.shieldPosition = shieldPosition;
  }
}