import 'package:EasyEat/screens/favourites_screen.dart';
import 'package:EasyEat/screens/home_screen.dart';
import 'package:EasyEat/screens/recipes_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TabNavigationItem {
  final Widget page;
  final Widget title;
  final Icon icon;

  TabNavigationItem({
    @required this.page,
    @required this.title,
    @required this.icon,
  });

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: HomeScreen(),
          icon: Icon(Icons.home),
          title: Text("Home"),
        ),
        TabNavigationItem(
          page: RecipesPage(),
          icon: Icon(Icons.star),
          title: Text("Shop"),
        ),
        TabNavigationItem(
          page: FavouritePage(),
          icon: Icon(Icons.favorite),
          title: Text("Favourites"),
        ),
      ];
}
