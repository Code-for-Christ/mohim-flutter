import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/style.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/contact/component/information_card.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '',
      appBarColor: INPUT_BG_COLOR,
      backgroudColor: INPUT_BG_COLOR,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 7,
                        color: Color(0x411D2429),
                        offset: Offset(0, 1),
                      ),
                    ]),
                child: Stack(
                  children: [
                    Container(
                      width: 120,
                      height: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: INPUT_BG_COLOR),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1574914629385-46448b767aec?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8bGF0dGV8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
                        width: 120,
                        height: 140,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              Gap(4),
              Text(
                '김성겸',
                style: titleTextStyle.copyWith(color: Colors.black),
              ),
              Text(
                '35구역 형제',
                style: body1TextStyle.copyWith(
                    fontWeight: FontWeight.w600, color: BODY_TEXT_COLOR),
              ),
              Gap(16),
              ElevatedButton(
                onPressed: () async {
                  String number = '01077337981';
                  final url = Platform.isIOS ? 'tel://$number' : 'tel:$number';
                  await launchUrl(Uri.parse(url));
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: PRIMARY_COLOR,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                child: Wrap(
                  children: [
                    Icon(CupertinoIcons.phone_fill),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '010-0000-0000',
                      style: body1TextStyle.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Gap(30),
              InformationCard(
                icon: CupertinoIcons.car,
                height: 50,
                text: '차량번호',
                data: '14다 6170',
              ),
              Gap(16),
              InformationCard(
                icon: CupertinoIcons.house_fill,
                height: 50,
                text: '집주소',
                data: '파주시 가람로 116번길 130',
              ),
              Gap(16),
              InformationCard(
                icon: CupertinoIcons.gift_fill,
                height: 50,
                text: '구원생일',
                data: '2018년 8월',
              ),
              Gap(16),
              InformationCard(
                icon: Icons.bookmark,
                height: 50,
                text: '소속',
                data: '청년회',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
