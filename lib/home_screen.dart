import 'package:flutter/material.dart';
import 'package:movies_app/My_theme/my_theme.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_Screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  List<Widget> homeBody = [
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(canvasColor: MyTheme.bottomNavigationBackgroundColor),
        child: SizedBox(
          height: screenSize.height * .08,
          child: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                selectedIndex = index;
                setState(() {});
              },
              items: [
                BottomNavigationBarItem(
                  icon: bottomNavIcon(assetImage: "assets/images/home.png"),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: bottomNavIcon(assetImage: "assets/images/search.png"),
                  label: "Search",
                ),
                BottomNavigationBarItem(
                  icon: bottomNavIcon(assetImage: "assets/images/browse.png"),
                  label: "Browse",
                ),
                BottomNavigationBarItem(
                  icon:
                      bottomNavIcon(assetImage: "assets/images/watch_list.png"),
                  label: "WatchList",
                ),
              ]),
        ),
      ),
      body: homeBody[selectedIndex],
    );
  }

  Padding bottomNavIcon({required String assetImage}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ImageIcon(
        AssetImage(assetImage),
      ),
    );
  }
}

