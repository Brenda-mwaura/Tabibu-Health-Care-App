import 'package:flutter/material.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/widgets/spinner.dart';

class ProfileTabView extends StatelessWidget {
  const ProfileTabView({Key? key}) : super(key: key);

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
              // responsive profile picture with camera icon
              Stack(
                children: [
                  //circle avatar
                  CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.grey,
                      child: const CircleAvatar(
                          radius: 65,
                          backgroundImage:
                              AssetImage("assets/images/default.png"))
                      //  CircleAvatar(
                      //       radius: 65,
                      //       backgroundImage:
                      //     ),
                      ),
                  //camera icon
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Styles.primaryColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return ImagePickerBottomSheet();
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
