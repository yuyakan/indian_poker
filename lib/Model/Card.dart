import 'dart:math' as math;

class Card {
  static int _TOTAL_NUMBER = 54;
  var random = math.Random();

  void insertJoker(bool isUsedJoker) {
    if (isUsedJoker) {
      _TOTAL_NUMBER = 54;
    } else {
      _TOTAL_NUMBER = 52;
    }
  }

  int drow() {
    return random.nextInt(_TOTAL_NUMBER);
  }
}
