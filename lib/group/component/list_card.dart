import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/const/style.dart';

class ListCard extends StatelessWidget {
  ListCard({super.key, required this.cell, required this.onTap});
  final String cell;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Wrap(
        children: [
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cell,
                        style: body1TextStyle.copyWith(
                            fontSize: 18, color: Colors.black),
                      ),
                      // Text(
                      //   '00명',
                      //   style: body2TextStyle,
                      // ),
                    ],
                  ),
                  Spacer(),
                  Icon(CupertinoIcons.chevron_forward),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
