import 'package:flutter/material.dart';

import '../../../../constants/gaps.dart';
import '../../../../constants/sizes.dart';

class UserAccount extends StatelessWidget {
  const UserAccount({
    super.key,
    required this.number,
    required this.content,
  });

  final String number;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Sizes.size18,
          ),
        ),
        Gaps.v3,
        Text(
          content,
          style: TextStyle(
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}
