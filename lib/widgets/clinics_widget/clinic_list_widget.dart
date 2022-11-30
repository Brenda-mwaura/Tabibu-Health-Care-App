import 'package:flutter/material.dart';
import 'package:tabibu/configs/styles.dart';

class ClinicWidget extends StatelessWidget {
  const ClinicWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 120,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage("assets/images/afya.jpeg"),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(5)),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Equity afya Thika",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Location"),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          // IgnorePointer(
                          //   child: RatingBar.builder(
                          //     initialRating: 3,
                          //     minRating: 1,
                          //     unratedColor: Styles.appSecondaryColor,
                          //     direction: Axis.horizontal,
                          //     allowHalfRating: true,
                          //     itemCount: 5,
                          //     itemSize: 20,
                          //     itemPadding: EdgeInsets.symmetric(horizontal: 0),
                          //     itemBuilder: (context, index) => Icon(
                          //       index >= book.rating
                          //           ? Icons.star_border_outlined
                          //           : Icons.star,
                          //       color: Styles.appSecondaryColor,
                          //     ),
                          //     maxRating: 5,
                          //     onRatingUpdate: (double value) {},
                          //   ),
                          // ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "5.0",
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
