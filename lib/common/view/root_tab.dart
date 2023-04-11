import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/contact/view/contact_screen.dart';
import 'package:phonebook/group/view/group_screen.dart';
import 'package:phonebook/profile/view/profile_screen.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController controller;
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 3, vsync: this);
    controller.addListener(tabListener);
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: TabBarView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
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
          type: BottomNavigationBarType.fixed,
          onTap: (int index) {
            controller.animateTo(index);
          },
          currentIndex: index,
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
