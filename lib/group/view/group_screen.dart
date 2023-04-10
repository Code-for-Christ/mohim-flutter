import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/style.dart';
import 'package:phonebook/group/controller/group_controller.dart';
import 'package:phonebook/group/view/gathering_list_screen.dart';
import 'package:phonebook/group/view/ministry_list_screen.dart';
import 'package:phonebook/group/view/parish_list_screen.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _selectedColor = Color(0xff1a73e8);
  final _unselectedColor = Color(0xff5f6368);

  final _tabs = [
    Tab(text: '구역별'),
    Tab(text: '봉사별'),
    Tab(text: '회별'),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: TabBarView(
        controller: _tabController,
        children: [
          ParishListScreen(),
          MinistryScreen(),
          GatheringListScreen(),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: PRIMARY_COLOR,
      title: Text(
        '그룹',
        style: titleTextStyle.copyWith(color: Colors.white, fontSize: 22),
      ),
      elevation: 0,
      centerTitle: false,
      bottom: PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight - 12),
        child: Container(
          height: kToolbarHeight + 12,
          padding: const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
          decoration: BoxDecoration(
            color: PRIMARY_COLOR,
            border: Border(
              bottom: BorderSide(
                color: Colors.white,
                width: 0.0,
              ),
            ),
            // borderRadius: BorderRadius.only(
            //     topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
                color: Colors.white),
            labelColor: PRIMARY_COLOR,
            unselectedLabelColor: Colors.white,
            tabs: _tabs,
            labelStyle: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
