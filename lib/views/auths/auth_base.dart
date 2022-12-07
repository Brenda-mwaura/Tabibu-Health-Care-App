import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tabibu/configs/styles.dart';

class AuthBase extends StatelessWidget {
  final Widget body;
  final String? title;
  final String? subtitle;
  final String? image;

  final bool showBackIcon;
  const AuthBase(
      {Key? key,
      required this.body,
      this.title,
      this.subtitle,
      this.image,
      required this.showBackIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DoubleBack(
          message: "Press back again to exit",
          textStyle: const TextStyle(
            fontSize: 13,
            color: Colors.white,
          ),
          background: Styles.primaryColor,
          backgroundRadius: 30,
          child: Container(
            padding: const EdgeInsets.only(
              top: 10,
              left: 15,
              right: 15,
            ),
            height: double.infinity,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: [
                Stack(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          splashColor: Theme.of(context).splashColor,
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: showBackIcon == true
                                ? const Icon(
                                    Icons.arrow_back_ios,
                                    size: 20,
                                  )
                                : const SizedBox(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: SvgPicture.asset(
                    image!,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  subtitle!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Color.fromARGB(255, 154, 154, 154),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                body,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
