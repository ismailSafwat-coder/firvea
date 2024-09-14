import 'package:flutter/material.dart';
import 'package:frivea/providers/gamepageprovider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final String difficultylevel;
  HomePage({super.key, required this.difficultylevel});
  double? _deviceHeight, _deviceWidth;
  GamePageProvider? _pageProvider;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) =>
          GamePageProvider(context: context, difficultylevel: difficultylevel),
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(builder: (context) {
      _pageProvider = context.watch<GamePageProvider>();
      if (_pageProvider!.Qustions != null) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: _deviceHeight! * 0.05),
              child: _gameUI(),
            ),
          ),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      }
    });
  }

  Widget _gameUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _qustionText(),
        Column(
          children: [
            _trueButtom(),
            SizedBox(
              height: _deviceHeight! * 0.018,
            ),
            _FalseButtom(),
          ],
        ),
      ],
    );
  }

  Widget _qustionText() {
    return Text(
      _pageProvider!.getCurrentQuestionText(),
      style: const TextStyle(
        fontSize: 25,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _trueButtom() {
    return MaterialButton(
      color: Colors.green,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.10,
      onPressed: () {
        _pageProvider?.answerQustion("True");
      },
      child: const Text(
        "True",
        style: TextStyle(fontSize: 25),
      ),
    );
  }

  Widget _FalseButtom() {
    return MaterialButton(
      color: Colors.red,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.10,
      onPressed: () {
        _pageProvider?.answerQustion("False");
      },
      child: const Text(
        "False",
        style: TextStyle(fontSize: 25),
      ),
    );
  }
}
