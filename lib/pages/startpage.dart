import 'package:flutter/material.dart';
import 'package:frivea/pages/homepage.dart';
import 'package:frivea/providers/gamepageprovider.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  double? _deviceHeight, _deviceWidth;
  int difficulty = 0;
  List difficultylist = ["Easy", "Medium", "Hard"];
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: BuildUI(),
      ),
    );
  }

  Widget BuildUI() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _deviceHeight! * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Texttitle(),
          sildermove(),
          _Buttom(),
        ],
      ),
    );
  }

  Center Texttitle() {
    return const Center(
      child: Column(
        children: [
          Text(
            "Frivia",
            style: TextStyle(
              fontSize: 45,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text("deficulty",
              style: TextStyle(
                fontSize: 21,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ))
        ],
      ),
    );
  }

  Widget _Buttom() {
    return MaterialButton(
      color: Colors.blue,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.10,
      onPressed: () {
        print(difficultylist[difficulty]);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomePage(
                  difficultylevel:
                      difficultylist[difficulty].toString().toLowerCase(),
                )));
      },
      child: const Text(
        "Start",
        style: TextStyle(fontSize: 25, color: Colors.white),
      ),
    );
  }

  Widget sildermove() {
    return Slider(
      value: difficulty.toDouble(),
      min: 0,
      divisions: 2,
      max: 2,
      label: difficultylist[difficulty],
      onChanged: (value) {
        print(value);
        setState(() {
          difficulty = value.toInt();
        });
      },
    );
  }
}
