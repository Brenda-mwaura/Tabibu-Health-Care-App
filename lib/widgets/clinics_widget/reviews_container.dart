import 'package:flutter/material.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/data/models/clinic_review_model.dart';
import 'package:intl/intl.dart';

class ReviewsContainer extends StatelessWidget {
  // clinic
  final ClinicReview clinicReview;
  const ReviewsContainer({Key? key, required this.clinicReview})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var createdAt = DateFormat("dd-MM-yyyy")
        .format(DateTime.parse(clinicReview.createdAt.toString()));

    return Container(
      margin: const EdgeInsets.only(
        left: 5.0,
        right: 5,
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

            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            child: Row(
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
                    Text(clinicReview.patient!.user!.fullName.toString(),
                        style: Styles.custom18(context,
                            fontColor: Colors.black,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(createdAt,
                        style: Styles.custom18(context,
                            fontColor: Colors.grey,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.star,
                  color: Colors.orange,
                  size: MediaQuery.of(context).size.width * 0.05,
                ),
                Text(clinicReview.rating.toString(),
                    style:
                        Styles.custom18(context, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            clinicReview.comment.toString(),
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
