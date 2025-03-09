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
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomProvider>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: _screens[bottomNavProvider.currentIndex],
      bottomNavigationBar: Container(
        height: size.height*.1,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white70,
          boxShadow: [
            BoxShadow(
              color: Colors.white70,
              blurRadius: 5,
              spreadRadius: 3,
            ),
          ],
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: GNav(
            backgroundColor: Colors.white,
            color: Colors.grey,
            activeColor: Theme.of(context).primaryColor,
            tabBackgroundColor: Colors.white.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
      ),
    );
  }
}

// Image.asset('assets/icons/home.png',height: 30,width: 30,