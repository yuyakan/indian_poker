import 'package:flutter/material.dart';
import 'package:indian_poker/ButtonType.dart';
import 'package:indian_poker/IndianPokerViewModel.dart';

class IndianPokerView extends StatefulWidget {
  const IndianPokerView({
    Key? key,
  }) : super(key: key);

  @override
  State<IndianPokerView> createState() => _IndianPokerView();
}

class _IndianPokerView extends State<IndianPokerView> {
  IndianPokerViewModel indianPokerViewModel = IndianPokerViewModel();
  ButtonType buttonType = ButtonType.drow;
  String card = "img/back.png";
  bool isDrowed = false;
  bool isActivateButton = true;
  bool _isUsedJoker = true;
  double _position = 0;
  double _opacity = 0;

  MaterialButton _showButton(Size size) {
    switch (buttonType) {
      case ButtonType.drow:
        return MaterialButton(
          onPressed: _drow,
          child: Text("Drow",
              style: TextStyle(
                  fontSize: size.width > 740
                      ? size.width * 0.03
                      : size.width * 0.055)),
          padding: EdgeInsets.all(
              size.width > 740 ? size.width * 0.04 : size.width * 0.065),
          color: Color.fromARGB(255, 5, 202, 169),
          textColor: Colors.white,
          shape: CircleBorder(),
        );
      case ButtonType.open:
        return MaterialButton(
          onPressed: isActivateButton ? _open : null,
          child: Text("Open",
              style: TextStyle(
                  fontSize: size.width > 740
                      ? size.width * 0.03
                      : size.width * 0.055)),
          padding: EdgeInsets.all(
              size.width > 740 ? size.width * 0.04 : size.width * 0.065),
          color: Color.fromARGB(255, 255, 54, 23),
          textColor: Colors.white,
          shape: CircleBorder(),
        );
      case ButtonType.change:
        return MaterialButton(
          onPressed: _change,
          child: Text("Change",
              style: TextStyle(
                  fontSize: size.width > 740
                      ? size.width * 0.03
                      : size.width * 0.055)),
          padding: EdgeInsets.all(
              size.width > 740 ? size.width * 0.04 : size.width * 0.065),
          color: Color.fromARGB(255, 255, 162, 2),
          textColor: Colors.white,
          shape: CircleBorder(),
        );
    }
  }

  Future<void> _drow() async {
    _position = -100;
    setState(() {});
    await Future.delayed(Duration(milliseconds: 1200), () {
      isDrowed = true;
      _opacity = 1;
      buttonType = ButtonType.open;
      _position = 0;
    });
    setState(() {});
  }

  Future<void> _open() async {
    setState(() {
      isActivateButton = false;
      card = "img/3.png";
    });
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      card = "img/2.png";
    });
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      card = "img/1.png";
    });
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      buttonType = ButtonType.change;
      card = indianPokerViewModel.open();
      isActivateButton = true;
    });
  }

  void _change() {
    setState(() {
      buttonType = ButtonType.open;
      card = "img/back.png";
    });
  }

  void _next() {
    setState(() {
      isDrowed = false;
      buttonType = ButtonType.drow;
      card = "img/back.png";
      isActivateButton = true;
      _isUsedJoker = true;
      _position = 0;
      _opacity = 0;
    });
  }

  void _changeSwitch(bool e) {
    setState(() {
      _isUsedJoker = e;
      indianPokerViewModel.usedJoker(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Row(
              children: [
                Spacer(),
                Stack(children: [
                  Visibility(
                      visible: !isDrowed,
                      maintainSize: true,
                      maintainState: true,
                      maintainAnimation: true,
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: size.width * 0.04,
                            top: size.width > 740 ? 0.0 : size.width * 0.05),
                        child: Column(
                          children: [
                            Text("Joker",
                                style: TextStyle(
                                    fontSize: size.width > 740
                                        ? size.width * 0.05
                                        : size.width * 0.07,
                                    color: Color.fromARGB(255, 118, 1, 173),
                                    fontWeight: FontWeight.bold)),
                            Switch(
                              value: _isUsedJoker,
                              onChanged: (e) {
                                _changeSwitch(e);
                              },
                            ),
                          ],
                        ),
                      )),
                  Visibility(
                      visible: isDrowed && isActivateButton,
                      maintainSize: true,
                      maintainState: true,
                      maintainAnimation: true,
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: size.width > 740 ? 0.0 : size.width * 0.05),
                          child: MaterialButton(
                            onPressed: _next,
                            child: Text(
                              "Next",
                              style: TextStyle(
                                  fontSize: size.width > 740
                                      ? size.width * 0.05
                                      : size.width * 0.07,
                                  color: Color.fromARGB(255, 4, 190, 159),
                                  fontWeight: FontWeight.bold),
                            ),
                          )))
                ])
              ],
            ),
            Spacer(),
            Stack(children: [
              Visibility(
                  visible: !isDrowed,
                  maintainSize: true,
                  maintainState: true,
                  maintainAnimation: true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.08),
                        child: Image.asset(
                          "img/deck.png",
                          width: size.width * 0.75,
                        ),
                      )
                    ],
                  )),
              Visibility(
                  visible: !isDrowed,
                  maintainSize: true,
                  maintainState: true,
                  maintainAnimation: true,
                  child: AnimatedContainer(
                      alignment: Alignment.center,
                      duration: const Duration(seconds: 1),
                      transform: Matrix4.translationValues(0, _position, 0),
                      child: Padding(
                        padding: EdgeInsets.only(top: size.height * 0.08),
                        child: Image.asset(
                          "img/deck_top2.png",
                          width: size.width * 0.75,
                        ),
                      ))),
              Visibility(
                  visible: isDrowed,
                  maintainSize: true,
                  maintainState: true,
                  maintainAnimation: true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedOpacity(
                        opacity: _opacity,
                        curve: Curves.easeIn,
                        duration: Duration(milliseconds: 1000),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            card,
                            width: size.width > 740
                                ? size.width * 0.48
                                : size.width * 0.75,
                          ),
                        ),
                      ),
                    ],
                  )),
            ]),
            Spacer(),
            Padding(
                padding: EdgeInsets.only(
                    top: size.width > 740
                        ? size.width * 0.01
                        : size.height * 0.03,
                    bottom: size.height * 0.05),
                child: _showButton(size)),
          ],
        ),
      ),
    );
  }
}
