import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;
  final Color? backgroudColor;
  final String? title;
  final Widget? bottomNavigationBar;
  final Color? appBarColor;
  final bool? centerTitle;
  final PreferredSizeWidget? appBarBottom;

  const DefaultLayout(
      {super.key,
      this.centerTitle = false,
      required this.child,
      this.backgroudColor = Colors.white,
      this.appBarColor,
      this.title,
      this.bottomNavigationBar,
      this.appBarBottom});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      backgroundColor: backgroudColor ?? Colors.white,
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  AppBar? renderAppBar() {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        backgroundColor: appBarColor,
        elevation: 0,
        title: Text(
          title!,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        foregroundColor: Colors.black,
        centerTitle: centerTitle,
        bottom: appBarBottom,
      );
    }
  }
}
