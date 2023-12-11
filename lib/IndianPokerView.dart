import 'package:flutter/material.dart';

class IndianPokerView extends StatefulWidget {
  const IndianPokerView({
    Key? key,
  }) : super(key: key);

  @override
  State<IndianPokerView> createState() => _IndianPokerView();
}

class _IndianPokerView extends State<IndianPokerView> {
  bool isDrowed = false;
  double _position = 0;
  double _opacity = 0;

  Future<void> _onTap() async {
    _position = -100;
    setState(() {});
    await Future.delayed(Duration(milliseconds: 1200), () {
      isDrowed = true;
      _opacity = 1;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                        child: Image.asset(
                          "img/back.png",
                          width: size.width * 0.75,
                        ),
                      ),
                    ],
                  )),
            ]),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.08),
              child: MaterialButton(
                onPressed: _onTap,
                child:
                    Text("Drow", style: TextStyle(fontSize: size.width * 0.08)),
                padding: EdgeInsets.all(size.width * 0.08),
                color: Color.fromARGB(255, 6, 221, 221),
                textColor: Colors.white,
                shape: CircleBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   final Size size = MediaQuery.of(context).size;
  //   bool _radians = true;
  //   void _onTap() {
  //     setState(() {
  //       if (_radians) {
  //         _radians = false;
  //       } else {
  //         _radians = true;
  //       }
  //     });
  //     print(_radians);
  //   }

  //   return Scaffold(
  //       body: Container(
  //     child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
  //       Column(mainAxisAlignment: MainAxisAlignment.center, children: [
  //         Image.asset(
  //           "img/deck.png",
  //           width: _radians ? size.width * 0.75 : 0,
  //         ),
  //         Padding(
  //           padding: EdgeInsets.only(top: size.height * 0.08),
  //           child: MaterialButton(
  //             onPressed: _onTap,
  //             child:
  //                 Text("Drow", style: TextStyle(fontSize: size.width * 0.08)),
  //             padding: EdgeInsets.all(size.width * 0.08),
  //             color: Color.fromARGB(255, 6, 221, 221),
  //             textColor: Colors.white,
  //             shape: CircleBorder(),
  //           ),
  //         ),
  //       ])
  //     ]),
  //   ));
  // }
}
