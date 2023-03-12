import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/data/models/clinic_model.dart';
import 'package:tabibu/views/clinics/clinic_details.dart';

class HomePageListView extends StatefulWidget {
  //clinic
  final String? clinicName;
  final String? clinicAddress;
  final double? clinicRating;
  final String? clinicImage;

  HomePageListView({
    Key? key,
    this.clinicName,
    this.clinicAddress,
    this.clinicRating,
    this.clinicImage,
  }) : super(key: key);

  @override
  State<HomePageListView> createState() => _HomePageListViewState();
}

class _HomePageListViewState extends State<HomePageListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 10),
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
                image: DecorationImage(
                  image: NetworkImage(
                    widget.clinicImage.toString(),
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(5)),
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            padding: const EdgeInsets.all(6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.clinicName.toString(),
                  style: Styles.normal(context,
                      fontColor: Colors.black, fontWeight: FontWeight.w700),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  widget.clinicAddress.toString(),
                  style: Styles.custom18(context,
                      fontColor: Colors.grey, fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    IgnorePointer(
                      child: RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        unratedColor: Colors.grey,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 18,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                        itemBuilder: (context, index) => Icon(
                          index >= widget.clinicRating!.toInt()
                              ? Icons.star_border_outlined
                              : Icons.star,
                          color: Colors.amber,
                        ),
                        maxRating: 5,
                        onRatingUpdate: (double value) {},
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
