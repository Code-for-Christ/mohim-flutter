import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:multi_masked_formatter/multi_masked_formatter.dart';
import 'package:phonebook/common/component/custom_rounded_button.dart';
import 'package:phonebook/common/component/custom_text_form_field.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/style.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/user/controller/auth_controller.dart';
import 'package:phonebook/user/controller/church_controller.dart';
import 'package:phonebook/user/model/church_model.dart';

class AuthenticateScreen extends StatefulWidget {
  const AuthenticateScreen({super.key});

  @override
  State<AuthenticateScreen> createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {
  List<ChurchModel> items = [];

  ChurchModel? selectedValue;
  final TextEditingController textEditingController = TextEditingController();
  final churchController = Get.put(ChurchController());

  bool isDisabled = true;

  ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    minimumSize: Size(double.infinity, 60),
    elevation: 0,
    disabledBackgroundColor: INPUT_BG_COLOR,
    disabledForegroundColor: Colors.white,
    backgroundColor: PRIMARY_COLOR,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(50)),
    ),
  );

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  String name = '';
  String phoneNumber = '';
  final churchCtrl = Get.put(ChurchController());
  final authCtrl = Get.put(AuthController());

  setDisabled() {
    if (name != '' && phoneNumber != '' && selectedValue != null) {
      setState(() {
        isDisabled = false;
      });
    } else {
      setState(() {
        isDisabled = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(child: SingleChildScrollView(
      child: SafeArea(
        child: Obx(() {
          return churchCtrl.churchs.isEmpty
              ? Center(
                  child: CircularProgressIndicator(
                    color: PRIMARY_COLOR,
                  ),
                )
              : SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '성도 인증하기',
                            style: titleTextStyle.copyWith(color: Colors.black),
                          ),
                        ),
                        Gap(50),
                        Center(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<ChurchModel>(
                              isExpanded: true,
                              hint: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  '교회를 선택하세요',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),

                              items: churchCtrl.churchs
                                  .map((item) => DropdownMenuItem(
                                        value: item,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 18),
                                          child: Text(
                                            item.name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              value: selectedValue,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),

                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value;
                                });
                                setDisabled();
                              },
                              buttonStyleData: const ButtonStyleData(
                                height: 60,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: INPUT_BG_COLOR,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                              ),
                              dropdownStyleData: const DropdownStyleData(
                                maxHeight: 200,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 50,
                              ),
                              dropdownSearchData: DropdownSearchData(
                                searchController: textEditingController,
                                searchInnerWidgetHeight: 50,
                                searchInnerWidget: Container(
                                  height: 50,
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    bottom: 4,
                                    right: 8,
                                    left: 8,
                                  ),
                                  child: TextFormField(
                                    expands: true,
                                    maxLines: null,
                                    controller: textEditingController,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 8,
                                      ),
                                      hintText: '교회를 검색하세요...',
                                      hintStyle: const TextStyle(fontSize: 13),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                searchMatchFn: (item, searchValue) {
                                  return (item.value!.name
                                      .toString()
                                      .contains(searchValue));
                                },
                              ),
                              //This to clear the search value when you close the menu
                              onMenuStateChange: (isOpen) {
                                if (!isOpen) {
                                  textEditingController.clear();
                                }
                              },
                            ),
                          ),
                        ),
                        Gap(20),
                        CustomTextFormField(
                          onChanged: (value) {
                            name = value;
                            setDisabled();
                          },
                          hintText: '이름을 입력하세요',
                          fontSize: 16,
                        ),
                        Gap(20),
                        CustomTextFormField(
                          onChanged: (value) {
                            phoneNumber = value;
                            setDisabled();
                          },
                          inputFormatters: [
                            MultiMaskedTextInputFormatter(
                                masks: ['xxx-xxxx-xxxx', 'xxx-xxx-xxxx'],
                                separator: '-')
                          ],
                          hintText: '전화번호를 입력하세요',
                          fontSize: 16,
                        ),
                        Gap(60),
                        ElevatedButton(
                          style: buttonStyle,
                          onPressed: isDisabled
                              ? null
                              : () async {
                                  setState(() {
                                    isDisabled = true;
                                  });
                                  await authCtrl.authenticate(
                                      selectedValue!.id, name, phoneNumber);
                                  setState(() {
                                    isDisabled = false;
                                  });
                                },
                          child: Text(
                            '인증하기',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Gap(25),
                        CustomRoundedButton(
                            color: PRIMARY_COLOR,
                            filled: false,
                            height: 60,
                            onTap: () => authCtrl.logout(),
                            text: '로그아웃')
                      ],
                    ),
                  ),
                );
        }),
      ),
    ));
  }
}
