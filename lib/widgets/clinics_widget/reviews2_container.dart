import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/data/models/clinic_review_model.dart';

class Reviews2Container extends StatelessWidget {
  final ClinicReview review;
  const Reviews2Container({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 5.0,
        right: 5,
        bottom: 10,
      ),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.red,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(review.patient!.user!.fullName.toString(),
                      style:
                          Styles.normal(context, fontWeight: FontWeight.w700)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                      DateFormat('dd-MM-yyyy')
                          .format(DateTime.parse(
                            review.createdAt.toString(),
                          ))
                          .toString(),
                      style: Styles.custom18(context,
                          fontColor: Colors.grey, fontWeight: FontWeight.w500)),
                ],
              ),
              const Spacer(),
              Icon(
                Icons.star,
                color: Colors.orange,
                size: MediaQuery.of(context).size.width * 0.05,
              ),
              Text(review.rating.toString(),
                  style: Styles.custom18(context, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            review.comment.toString(),
            style: Styles.custom18(context,
                fontColor: Colors.grey, fontWeight: FontWeight.w500),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
