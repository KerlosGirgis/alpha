import 'package:alpha/view/pages/cart_page.dart';
import 'package:alpha/view/pages/favourites_page.dart';
import 'package:alpha/view/pages/home_page.dart';
import 'package:alpha/view/pages/profile_page.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

final _pageController = PageController(initialPage: 0);

/// Controller to handle bottom nav bar and also handles initial page
final NotchBottomBarController _controller = NotchBottomBarController(index: 0);

int maxCount = 5;

@override
void dispose() {
  _pageController.dispose();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> bottomBarPages = [
      const HomePage(),
      const FavouritesPage(),
      const CartPage(),
      const ProfilePage()
    ];
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
        /// Provide NotchBottomBarController
        notchBottomBarController: _controller,
        color: Colors.white,
        showLabel: true,
        textOverflow: TextOverflow.visible,
        maxLine: 1,
        shadowElevation: 5,
        kBottomRadius: 28.0,

        notchColor: Colors.white,

        /// restart app if you change removeMargins
        removeMargins: false,
        bottomBarWidth: 500,
        showShadow: true,
        durationInMilliSeconds: 300,

        itemLabelStyle: const TextStyle(fontSize: 10),

        elevation: 1,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(
              Icons.home_outlined,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.home_filled,
              color: Colors.blueAccent,
            ),
            itemLabel: '',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.favorite_outline_sharp,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.favorite_sharp,
              color: Colors.red,
            ),
            itemLabel: '',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.shopping_bag,
              color: Colors.green,
            ),
            itemLabel: '',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.person_outline,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.person,
              color: Colors.redAccent,
            ),
            itemLabel: '',
          ),
        ],
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
        kIconSize: 24.0,
      )
          : null,
    );
  }
}