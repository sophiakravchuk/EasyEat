import 'package:EasyEat/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class TopBar {

  TopBar();

  PreferredSizeWidget build(BuildContext context) =>
      AppBar(
        backgroundColor: EasyEatColors.green,
        leading: IconButton(icon: Icon(
          Icons.arrow_back,
          color: EasyEatColors.white,
        ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HomeScreen()));
              },
              child: Text(
                "EasyEat",
                style: EasyEatTextStyle(
                  fontSize: 20,
                  textColor: EasyEatColors.white,
                ).style(),
              )),
          // Container(
          //   width: 70,
          // child:

          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomeScreen()));
            },
            child: Image.asset('assets/images/logo.png', scale: 8,),
          ),

        ],
      );
}


class TopBarHome {

  TopBarHome();

  PreferredSizeWidget build(BuildContext context) =>
      AppBar(
        backgroundColor: EasyEatColors.green,
        leading: Text(" "),
        actions: <Widget>[
          TextButton(
              child: Text(
                "EasyEat",
                style: EasyEatTextStyle(
                  fontSize: 20,
                  textColor: EasyEatColors.white,
                ).style(),
              )),
          // Container(
          //   width: 70,
          // child:

          GestureDetector(
            child: Image.asset('assets/images/logo_white.png', scale: 12,),
          ),
        ],
      );
}