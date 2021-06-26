import 'dart:ui';
import 'package:EasyEat/screens/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Constants{
  Constants._();
  static const double padding =20;
  static const double paddingVertical =40;
  static const double avatarRadius =45;
}

class WarningDialog extends StatefulWidget {

  const WarningDialog({Key key}) : super(key: key);

  @override
  _WarningDialogState createState() => _WarningDialogState();
}

class _WarningDialogState extends State<WarningDialog> {


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius
                  + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding
          ),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(color: Colors.black, offset: Offset(0, 10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text('Add ingredients to search the recipes',
                  style: EasyEatTextStyle(
                      textColor: EasyEatColors.darkGreen, fontSize: 25)
                      .style(),
                  textAlign: TextAlign.center),

              SizedBox(
                height: 25,
              ),

              Align(
                alignment: Alignment.center,
                child: ButtonTheme(
                  height: 50,
                  minWidth: 150,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: EasyEatColors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FlatButton(
                    color: EasyEatColors.orange.withOpacity(0.5),
                    highlightColor: EasyEatColors.lightGreen,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'OK',
                      style: EasyEatTextStyle(
                          textColor: EasyEatColors.darkGreen, fontSize: 18)
                          .style(),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          top: Constants.paddingVertical,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: Icon(
              Icons.fastfood_outlined,
              color: EasyEatColors.darkGreen,
              size: 40,
            ),
          ),
        ),
      ],
    );
  }

}