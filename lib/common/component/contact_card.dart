import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/style.dart';
import 'package:phonebook/contact/view/detail_screen.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(DetailScreen());
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            // BoxShadow(
            //   blurRadius: 1,
            //   color: Color(0x411D2429),
            //   offset: Offset(0, 1),
            // ),
          ],
        ),
        child: Row(children: [
          Stack(
            children: [
              Container(
                  width: 60,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: INPUT_BG_COLOR,
                  )),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'https://images.unsplash.com/photo-1574914629385-46448b767aec?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8bGF0dGV8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
                  width: 60,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Gap(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '이름',
                style: body1TextStyle,
              ),
              Text(
                '010-7733-7981',
                style: body2TextStyle,
              ),
            ],
          ),
          Spacer(),
          Icon(CupertinoIcons.chevron_forward)
        ]),
      ),
    );
  }
}
