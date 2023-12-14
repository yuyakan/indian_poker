import 'package:indian_poker/Model/Card.dart';
import 'package:indian_poker/Model/NumConvertCard.dart';

class IndianPokerViewModel {
  Card card = Card();

  String open() {
    NumConvertCard numConvertCard = NumConvertCard(card.drow());
    return "img/cards/${numConvertCard.mark()}${numConvertCard.number()}.png";
  }

  void usedJoker(bool isUsedJoker) {
    card.insertJoker(isUsedJoker);
  }
}
