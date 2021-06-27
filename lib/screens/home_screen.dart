import 'package:EasyEat/screens/top_bar.dart';
import 'package:EasyEat/services/recipe_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_screenutil/screenutil.dart';
import '../services/api_services.dart';
import '../services/meal_model.dart';

import 'constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();

  HomeScreen();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: DesignConfiguration.size, allowFontScaling: true);
    return Scaffold(
      appBar: TopBar().build(context),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
            return DefaultTabController(
              length: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 28),
                child: ListView(children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  _topText(context),
                  SizedBox(
                    height: 10,
                  ),
                  _search(context),
                  SizedBox(
                    height: 15,
                  ),
                  _addButton(),
                  SizedBox(
                    height: 30,
                  ),
                  _ingredientsList(),
                  SizedBox(
                    height: 200,
                  ),
                  _searchButton(),
                ]),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _topText(BuildContext context) => Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(50, 18, 18, 18),
            child: Center(
              child: Image.asset('assets/images/ingredients.png'),
            ),
          ),
          Column(children: <Widget>[
            Align(
              alignment: Alignment.center,
              // child: Padding(
              // padding: EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                child: Text(
                  "Add Your",
                  style: EasyEatTextStyle(
                    fontSize: 28,
                    textColor: EasyEatColors.black,
                  ).style(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              // child: Padding(
              // padding: EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                child: Text(
                  "Ingredients",
                  style: EasyEatTextStyle(
                    fontSize: 28,
                    textColor: EasyEatColors.black,
                  ).style(),
                ),
              ),
            ),
          ]),
          // ),
        ],
      );

  Widget _search(BuildContext context) => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: EasyEatColors.grey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Your ingredient',
                  hintStyle: EasyEatTextStyle(
                    textColor: EasyEatColors.darkGrey,
                    fontWeight: FontWeight.normal,
                  ).style(),
                  contentPadding: EdgeInsets.fromLTRB(18, 19, 18, 16),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
              child: Center(
                child: Icon(
                  Icons.search,
                  color: EasyEatColors.darkGrey,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
      );

  Future<void> _onAddButton() async {
    String id = '660261';
    RecipeInstructions instr = await ApiService.instance.getRecipeSteps(id);

    print(instr.ings[0].name);
    print(instr.steps[0]);



    print("ADD");
  }

  void _onRemoveButton() {
    print("REMOVE");
  }

  Widget _addButton() => Container(
        padding: EdgeInsets.only(top: 5),
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            primary: EasyEatColors.orange,
          ),
          child: Container(
            width: 60,
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: Icon(
              Icons.add,
              size: 40,
              color: EasyEatColors.white,
            ),
          ),
          onPressed: () => _onAddButton(),
        ),
      );

  Widget _ingredientsList() => Column(children: <Widget>[
        Row(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Apple',
              style: EasyEatTextStyle(
                fontSize: 22,
                textColor: EasyEatColors.darkGreen,
              ).style(),
            ),
          ),
          GestureDetector(
            onTap: () => _onRemoveButton(),
            child: Container(
              margin: EdgeInsets.only(left: 237),
              width: 23,
              height: 23,
              decoration: BoxDecoration(
                  color: EasyEatColors.lightGreen,
                  shape: BoxShape.circle,
                  border: Border.all(color: EasyEatColors.darkGreen)),
              child: Icon(
                Icons.remove,
                size: 15,
                color: EasyEatColors.darkGreen,
              ),
            ),
          ),
        ]),
        SizedBox(
          height: 15,
        ),
        Row(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Banana',
              style: EasyEatTextStyle(
                fontSize: 22,
                textColor: EasyEatColors.darkGreen,
              ).style(),
            ),
          ),
          GestureDetector(
            onTap: () => _onRemoveButton(),
            child: Container(
              margin: EdgeInsets.only(left: 224),
              width: 23,
              height: 23,
              decoration: BoxDecoration(
                  color: EasyEatColors.lightGreen,
                  shape: BoxShape.circle,
                  border: Border.all(color: EasyEatColors.darkGreen)),
              child: Icon(
                Icons.remove,
                size: 15,
                color: EasyEatColors.darkGreen,
              ),
            ),
          ),
        ]),
      ]);

  void _onSearchButton() async {
    List<String> ingredients = ['apples', 'patata', 'sugar'];
    List<Meal> meals = await ApiService.instance.fetchRecipe(ingredients, 2);
    for(var meal in meals){
      print(meal.id.toString());
    }
  }

  Widget _searchButton() => Container(
        margin: const EdgeInsets.only(left: 60, right: 60),
        child: RawMaterialButton(
          onPressed: () => _onSearchButton(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          fillColor: EasyEatColors.darkGreen,
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            "Search",
            style: EasyEatTextStyle(
              fontSize: 22,
              textColor: EasyEatColors.white,
            ).style(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
}
