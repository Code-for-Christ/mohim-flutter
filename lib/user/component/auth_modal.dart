import 'package:phonebook/common/component/custom_rounded_button.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:flutter/material.dart';

class AuthModal extends StatelessWidget {
  AuthModal({super.key});

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: PRIMARY_COLOR,
    alignment: Alignment.center,
    fixedSize: Size(double.infinity, 30),
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Container(
          width: MediaQuery.of(context).size.width / 3 * 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  '성도인증이 필요합니다',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: PRIMARY_COLOR,
                      alignment: Alignment.center,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      fixedSize:
                          Size(MediaQuery.of(context).size.width / 1.7, 30),
                    ),
                    onPressed: () {},
                    child: Text('성도인증 하러가기')),
              ],
            ),
          )),
    );
  }
}
