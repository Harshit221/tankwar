import 'package:tankwar/components/weapons.dart';

class Accessories {
  int weakShield;
  int normalShield;
  int strongShield;
  int superShield;
  int repairKit;
  int teleport;
  List<Weapon> weapons;
  Accessories(){
    weakShield = normalShield = strongShield = superShield = teleport = 8;
    repairKit = 10;
    weapons = [
      Weapon(name: 'Fire Ball', quantity: 10, price: 20000),
      Weapon(name: 'Fuse Ball',  quantity: 10, price: 20000),
      Weapon(name: 'Large Ball',  quantity: 10, price: 20000),
      Weapon(name: 'Volcano Bomb',  quantity: 10, price: 20000),
      Weapon(name: 'Electric Bomb', quantity: 10, price: 20000),
      Weapon(name: 'Cracker Ball', quantity: 10, price: 20000),
      Weapon(name: 'Jump Ball', quantity: 10, price: 20000),
      Weapon(name: 'TankJump Ball', quantity: 10, price: 20000),
      Weapon(name: 'Fire Ball', quantity: 10, price: 20000),
      Weapon(name: 'Fire Ball', quantity: 10, price: 20000),
    ];
  }

  Accessories.fromJson(Map map) {
    weakShield = map['weakShield'];
    normalShield = map['normalShield'];
    strongShield = map['strongShield'];
    superShield = map['superShield'];
    repairKit = map['repairKit'];
    teleport = map['teleport'];
    weapons;
  }

  Map toJson() => {
    'weakShield': weakShield,
    'normalShield': normalShield,
    'strongShield': strongShield,
    'superShield': superShield,
    'repairKit': repairKit,
    'teleport': teleport,
    'weapons': weapons
  };

}