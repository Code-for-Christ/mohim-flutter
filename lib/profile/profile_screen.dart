import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:phonebook/common/component/custom_square_button.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/style.dart';
import 'package:phonebook/common/layout/default_layout.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroudColor: Colors.white,
      child: Column(
        children: [
          Container(
            alignment: Alignment.bottomLeft,
            height: MediaQuery.of(context).size.height / 4,
            width: double.infinity,
            decoration: BoxDecoration(
                color: PRIMARY_COLOR,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24))),
            child: Padding(
              padding: EdgeInsets.only(
                left: 24,
                bottom: 24,
                right: 24,
              ),
              child: Wrap(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _ProfileImage(),
                      Gap(40),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '김성겸B',
                            style: titleTextStyle.copyWith(
                                fontWeight: FontWeight.w600, fontSize: 24),
                          ),
                          Gap(4),
                          Text(
                            '010-7733-7981',
                            style: body1TextStyle.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Center(
              child: Column(
                children: [
                  _InfoBox(
                    icon: CupertinoIcons.mail_solid,
                    title: '이메일',
                    subTitle: 'test@mail.com',
                  ),
                  Divider(
                    color: INPUT_BG_COLOR,
                    thickness: 1,
                    height: 30,
                  ),
                  _InfoBox(
                    icon: CupertinoIcons.person_2_fill,
                    title: '구역',
                    subTitle: '35구역',
                  ),
                  Divider(
                    color: INPUT_BG_COLOR,
                    thickness: 1,
                    height: 30,
                  ),
                  _InfoBox(
                    icon: Icons.auto_awesome,
                    title: '봉사',
                    subTitle: '찬양대',
                  ),
                  Divider(
                    color: INPUT_BG_COLOR,
                    thickness: 1,
                    height: 30,
                  ),
                  _InfoBox(
                    icon: Icons.bookmark,
                    title: '소속',
                    subTitle: '청년회',
                  ),
                  Divider(
                    color: INPUT_BG_COLOR,
                    thickness: 1,
                    height: 30,
                  ),
                  Gap(60),
                  CustomSquareButton(
                      color: PRIMARY_COLOR,
                      text: '정보수정 요청하기',
                      filled: true,
                      onTap: () {},
                      height: 60)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ProfileImage extends StatelessWidget {
  const _ProfileImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      height: 120,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        // boxShadow: [
        //   BoxShadow(
        //     blurRadius: 7,
        //     color: Color(0x411D2429),
        //     offset: Offset(0, 1),
        //   ),
        // ],
      ),
      child: Stack(
        children: [
          Container(
            width: 70,
            height: 90,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: INPUT_BG_COLOR),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              'https://images.unsplash.com/photo-1574914629385-46448b767aec?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8bGF0dGV8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
              width: 140,
              height: 180,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  const _InfoBox({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: PRIMARY_COLOR,
        ),
        Gap(16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: body2TextStyle.copyWith(
                  color: BODY_TEXT_COLOR,
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
            Gap(8),
            Text(
              subTitle,
              style: body1TextStyle.copyWith(
                  color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}
