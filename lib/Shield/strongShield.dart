import 'package:flutter/material.dart';
import 'package:tankwar/Shield/shield.dart';

class StrongShield extends ShieldDetails{
  StrongShield() {
    super.maxHealth = 300;
    super.color = Colors.purple;
    super.curHealth = maxHealth;
//    super.shieldPosition = shieldPosition;
  }
}