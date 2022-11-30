import 'package:flutter/material.dart';
import 'package:tabibu/configs/styles.dart';

class SuggestedClinic extends StatelessWidget {
  const SuggestedClinic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 18.0,
        right: 18.0,
      ),
      padding: const EdgeInsets.only(
        bottom: 15,
        left: 1,
        right: 1,
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
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: const DecorationImage(
                image: AssetImage("assets/images/afya.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
              left: 20,
              right: 15,
            ),
            child: Container(
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text(
                        "Equity Afya Nairobi CBD",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      // spacer
                      Spacer(),
                      //5 the star rating
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 20,
                      ),
                      SizedBox(width: 3),
                      Text(
                        "5.0",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Makao Road, 67 N",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "5 mins walk",
                      style: TextStyle(
                        color: Styles.primaryColor,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
