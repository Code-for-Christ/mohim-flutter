import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/contact/view/contact_screen.dart';
import 'package:phonebook/group/view/group_screen.dart';
import 'package:phonebook/profile/profile_screen.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: IndexedStack(
        index: _selectedIndex,
        children: [
          ContactScreen(),
          GroupScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: PRIMARY_COLOR,
          unselectedItemColor: BODY_TEXT_COLOR,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.phone),
              label: '연락처',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline),
              label: '그룹',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: '프로필',
            ),
          ]),
    );
  }
}
