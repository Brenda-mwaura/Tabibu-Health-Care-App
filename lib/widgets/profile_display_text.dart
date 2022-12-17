import 'package:flutter/material.dart';
import 'package:tabibu/configs/styles.dart';

class ProfileText extends StatelessWidget {
  final IconData icon;
  final String displayTitle;
  final String? text;
  final int? maxLines;
  final TextOverflow? overflow;

  const ProfileText(
      {Key? key,
      required this.icon,
      required this.displayTitle,
      this.overflow,
      this.text,
      this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Styles.primaryColor,
          size: 26,
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                displayTitle,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Text(
                text ?? "",
                style: const TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(221, 69, 69, 69),
                  fontWeight: FontWeight.w500,
                ),
                maxLines: maxLines,
                overflow: overflow,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
