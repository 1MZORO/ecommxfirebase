import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import '../../Provider_Global/BottomProvider.dart';
import 'HomeScreen.dart';
import 'NotificationScreen.dart';
import 'OrderScreen.dart';
import 'ProfileScreen.dart';

class BottomNavTabs extends StatefulWidget {
  const BottomNavTabs({super.key});

  @override
  State<BottomNavTabs> createState() => _BottomNavTabsState();
}

class _BottomNavTabsState extends State<BottomNavTabs> {
  final List<Widget> _screens = [
    HomeScreen(),
    NotificationScreen(),
    OrderScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomProvider>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _screens[bottomNavProvider.currentIndex],
      ),
      bottomNavigationBar: Container(
        height: size.height * 0.08, // Fixed height for consistency
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: GNav(
          backgroundColor: Colors.transparent,
          color: Colors.grey,
          activeColor: Theme.of(context).primaryColor,
          tabBackgroundColor: Colors.blue.withOpacity(0.1),
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05, // Adjusted for better spacing
            vertical: 10, // Fixed vertical padding
          ),
          gap: 8,
          onTabChange: (index) => bottomNavProvider.changeTab(index),
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
              iconColor: bottomNavProvider.currentIndex == 0 ? Theme.of(context).primaryColor : Colors.grey,
            ),
            GButton(
              icon: Icons.notifications,
              text: 'Notifications',
              iconColor: bottomNavProvider.currentIndex == 1 ? Theme.of(context).primaryColor : Colors.grey,
            ),
            GButton(
              icon: Icons.shopping_cart,
              text: 'Orders',
              iconColor: bottomNavProvider.currentIndex == 2 ? Theme.of(context).primaryColor : Colors.grey,
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
              iconColor: bottomNavProvider.currentIndex == 3 ? Theme.of(context).primaryColor : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
