import 'package:flutter/material.dart';

class ProfileEditTabView extends StatelessWidget {
  const ProfileEditTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollable(
      viewportBuilder: (context, position) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        );
      },
    );
  }
}
