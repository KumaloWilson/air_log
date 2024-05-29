import 'package:air_log/views/crew_member_module/home/home.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import '../../../constant/colors.dart';
import '../universal_screens/profile/profile_screen.dart';

class CrewMemberNavBar extends StatefulWidget {
  const CrewMemberNavBar({super.key});

  @override
  State<CrewMemberNavBar> createState() => _CrewMemberNavBarState();
}

class _CrewMemberNavBarState extends State<CrewMemberNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: GNav(
              mainAxisAlignment: MainAxisAlignment.center,
              rippleColor: Pallete.primaryColor,
              hoverColor: Pallete.primaryColor,
              gap: 8,
              activeColor: Pallete.primaryColor,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}