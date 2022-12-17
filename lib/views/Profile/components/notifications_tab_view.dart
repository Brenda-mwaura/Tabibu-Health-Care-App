import 'package:flutter/material.dart';
import 'package:tabibu/views/home/components/home_list_view.dart';
import 'package:tabibu/widgets/clinics_widget/expandable_description.dart';

class NotificationTabView extends StatelessWidget {
  const NotificationTabView({Key? key}) : super(key: key);

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
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 12,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 35,
                          backgroundImage:
                              AssetImage("assets/images/afya.jpeg"),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Equity Afya Nairobi CBD",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "2hrs ago",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              //notification
                              const Text(
                                "You have a new appointment with Dr. John Doe on 12th Jan 2023 at 10:00am at Equity Afya Nairobi CBD. Please be on time.",
                                style: TextStyle(
                                  color: Color.fromARGB(221, 69, 69, 69),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),

                        // notification
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
