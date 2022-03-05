import 'dart:math';

class Wind {
  double windPower = 0;
  final int minPower = -30;
  final int maxPower = 30;
  final int maxChange = 20;
  final double gravity = 8;
  Random random;
  Function update;
  Wind() {
    random = Random();
    windPower = random.nextDouble() * maxPower / 2;
    windPower *= (random.nextInt(100)%2 == 0 ? 1 : -1);
  }

  void updateWind(){
    update();
  }

  bool windInRange(double windPower) {
    return windPower < maxPower && windPower > minPower;
  }

}