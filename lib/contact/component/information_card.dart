import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/style.dart';

class InformationCard extends StatelessWidget {
  double? height;
  IconData? icon;
  String text;
  String data;
  InformationCard({
    super.key,
    this.height = 100,
    this.icon = Icons.circle,
    required this.text,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: double.infinity,
      height: height,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      child: InkWell(
        onTap: () {
          Clipboard.setData(ClipboardData(text: data));
          Get.rawSnackbar(message: '$text 정보가 복사되었습니다.');
        },
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        child: Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(children: [
              Icon(
                icon,
                color: PRIMARY_COLOR,
                size: 8,
              ),
              Gap(8),
              Text(
                text,
                style: body2TextStyle.copyWith(
                    color: BODY_TEXT_COLOR, fontWeight: FontWeight.w500),
              ),
              Spacer(),
              SingleChildScrollView(
                child: SizedBox(
                  width: 200,
                  child: Text(
                    data,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: body2TextStyle.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.black),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
