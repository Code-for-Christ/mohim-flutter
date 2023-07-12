import 'package:flutter/material.dart';
import 'package:phonebook/common/const/style.dart';

class LeaderCard extends StatelessWidget {
  const LeaderCard({super.key, required this.name, required this.role});
  final String name;
  final String role;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 96,
          width: 76,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        SizedBox(
          width: 70,
          child: Text(
            role,
            style: body2TextStyle,
            maxLines: 1,
            overflow: TextOverflow.clip,
          ),
        ),
        Text(name),
      ],
    );
  }
}
