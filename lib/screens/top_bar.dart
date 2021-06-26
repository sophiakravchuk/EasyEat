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
          onPressed: () => print('BACK'),
        ),
        actions: <Widget>[
          TextButton(
              onPressed: () => print('TO HOME'),
              child: Text(
                "EasyEat",
                style: EasyEatTextStyle(
                  fontSize: 20,
                  textColor: EasyEatColors.white,
                ).style(),
              )),
          IconButton(
            icon: Icon(
              Icons.free_breakfast,
              color: EasyEatColors.white,
            ),
            onPressed: () {
              print('TO HOME');
            },
          ),
        ],
      );
}
