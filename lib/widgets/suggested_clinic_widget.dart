import 'package:flutter/material.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/data/models/clinic_model.dart';

class SuggestedClinic extends StatelessWidget {
  final Clinic clinic;
  final String travelTime;
  const SuggestedClinic(
      {Key? key, required this.clinic, required this.travelTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              image: DecorationImage(
                image: NetworkImage(clinic.displayImage.toString()),
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
                    children: [
                      Text(clinic.clinicName.toString(),
                          style: Styles.normal(context,
                              fontWeight: FontWeight.bold,
                              fontColor: Colors.black)),
                      // spacer
                      const Spacer(),
                      //5 the star rating
                      const Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 20,
                      ),
                      const SizedBox(width: 3),
                      Text(clinic.rating!.toStringAsFixed(1),
                          style: Styles.normal(context,
                              fontWeight: FontWeight.bold,
                              fontColor: Colors.black)),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      clinic.address.toString(),
                      style: Styles.custom18(context,fontWeight: FontWeight.w500,fontColor: Colors.grey),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${travelTime.toString()} mins Walk",
                      style: Styles.custom18(context,fontWeight: FontWeight.w700,fontColor: Styles.primaryColor),
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
