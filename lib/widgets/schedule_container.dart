import 'package:flutter/material.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/widgets/buttons/schedule_button.dart';
import 'package:tabibu/widgets/clinics_widget/schedule_bottom_sheet.dart';

class ScheduleContainer extends StatelessWidget {
  const ScheduleContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 25,
        left: 10,
        top: 10,
        right: 10,
      ),
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Equity Afya Nairobi CBD",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "General Consultation",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/images/afya.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(
            color: Color.fromARGB(255, 199, 199, 199),
            thickness: 0.5,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.calendar_month,
                    color: Color.fromARGB(221, 69, 69, 69),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "12th May 2021",
                    style: TextStyle(
                      color: Color.fromARGB(221, 69, 69, 69),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: const [
                  Icon(
                    Icons.access_time,
                    color: Color.fromARGB(221, 69, 69, 69),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "10:00 AM",
                    style: TextStyle(
                      color: Color.fromARGB(221, 69, 69, 69),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              // confirmed green dot
              const Spacer(),
              Row(
                children: const [
                  Icon(
                    Icons.circle,
                    color: Colors.orange,
                    size: 10,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Confirmed",
                    style: TextStyle(
                      color: Color.fromARGB(221, 69, 69, 69),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          //buttons row
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  child: ScheduleButton(
                    onPressed: () {},
                    text: "Cancel",
                    fillColor: const Color.fromARGB(255, 244, 246, 250),
                    textColor: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  child: RawMaterialButton(
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return ScheduleBottomSheet(
                              title: "Reschedule",
                              formWidget: Form(
                                child: Column(
                                  children: [],
                                ),
                              ),
                            );
                          });
                    },
                    fillColor: Styles.primaryColor,
                    elevation: 5,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Reschedule",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
