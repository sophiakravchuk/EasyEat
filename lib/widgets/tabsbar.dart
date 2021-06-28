import 'package:EasyEat/screens/constants.dart';
import 'package:EasyEat/screens/favourites_screen.dart';
import 'package:EasyEat/screens/home_screen.dart';
import 'package:flutter/material.dart';

class TabsBarScreen extends StatefulWidget {
  @override
  _TabsBarScreenState createState() => _TabsBarScreenState();
}

class _TabsBarScreenState extends State<TabsBarScreen> {
  int _currentIndex = 0;

  List<GlobalKey<NavigatorState>> navKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final firstPage =
              !await navKeys[_currentIndex].currentState.maybePop();
          return firstPage;
        },
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: EasyEatColors.green,
            selectedItemColor: EasyEatColors.white,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                title: Text('Home'),
                activeIcon: Icon(
                  Icons.home,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                ),
                title: Text('Favourites'),
                activeIcon: Icon(
                  Icons.favorite,
                ),
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          body: Stack(
            children: [
              _buildOffstageNavigator(0),
              _buildOffstageNavigator(1),
            ],
          ),
        ));
  }

  Map<String, WidgetBuilder> _routes(BuildContext context, int index) {
    return {
      '/': (context) {
        return [
          HomeScreen(),
          FavouritePage(),
        ].elementAt(index);
      },
    };
  }

  Widget _buildOffstageNavigator(int index) {
    var routes = _routes(context, index);
    return Offstage(
      offstage: _currentIndex != index,
      child: Navigator(
        key: navKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routes[routeSettings.name](context),
          );
        },
      ),
    );
  }
}
