import 'package:EasyEat/screens/recipes_list_screen.dart';
import 'package:EasyEat/screens/top_bar.dart';
import 'package:EasyEat/services/recipe_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_screenutil/screenutil.dart';
import '../services/api_services.dart';
import '../services/meal_model.dart';
import 'package:EasyEat/screens/warning_dialog.dart';

import 'constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();

  HomeScreen();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();
  List<String> ingredients = [];

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: DesignConfiguration.size, allowFontScaling: true);
    return Scaffold(
      appBar: TopBarHome().build(context),
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
                    height: 20,
                  ),
                  Container(
                    height: 269,
                    child: ListView.separated(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 1,
                            ),
                        itemCount: 1,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return _ingredientsList();
                        }),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  _searchButton(),
                  SizedBox(
                    height: 15,
                  ),
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
                controller: _searchController,
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

  void _onAddButton() {
    setState(() {
      ingredients.add(_searchController.text);
    });
    _searchController.text = "";
  }

  void _onRemoveButton(int i) {
    setState(() {
      ingredients.remove(ingredients[i]);
    });
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

  Widget _ingredientsList() {
    List<Column> list = new List<Column>();
    for (var i = 0; i < ingredients.length; i++) {
      list.add(
        Column(children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    ingredients[i],
                    style: EasyEatTextStyle(
                      fontSize: 22,
                      textColor: EasyEatColors.darkGreen,
                    ).style(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: GestureDetector(
                    onTap: () => _onRemoveButton(i),
                    child: Container(
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
                ),
              ]),
          SizedBox(
            height: 10,
          ),
        ]),
      );
    }
    return new Column(children: list);
  }

  void _onSearchButton() async {
    List<Meal> meals = await ApiService.instance.fetchRecipe(ingredients, 2);

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => RecipesPage(meals: meals))).then((_) {
      setState(() {});
    });
  }

  Widget _searchButton() => Container(
        margin: const EdgeInsets.only(left: 60, right: 60),
        child: RawMaterialButton(
          onPressed: () => ingredients.isEmpty
              ? showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return WarningDialog();
                  })
              : _onSearchButton(),
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
