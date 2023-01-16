import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/data/models/clinic_model.dart';
import 'package:tabibu/providers/clinic_provider.dart';
import 'package:tabibu/views/clinics/clinic_reviews_screen.dart';
import 'package:tabibu/widgets/clinics_widget/expandable_description.dart';
import 'package:tabibu/widgets/clinics_widget/reviews_container.dart';
import 'package:tabibu/widgets/spinner.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutClinicTabView extends StatefulWidget {
  final Clinic clinic;
  AboutClinicTabView({Key? key, required this.clinic}) : super(key: key);

  @override
  State<AboutClinicTabView> createState() => _AboutClinicTabViewState();
}

class _AboutClinicTabViewState extends State<AboutClinicTabView> {
  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    var clinicProvider = Provider.of<ClinicProvider>(context, listen: false);
    await clinicProvider.getClinicAlbum(widget.clinic.id);
    await clinicProvider.getClinicReviews(widget.clinic.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: RefreshIndicator(
        onRefresh: _refresh,
        child: Scrollable(
          viewportBuilder: (context, position) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.clinic.displayImage.toString(),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    print("launching....");
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        print("Launch this");
                                        _launchCaller("${widget.clinic.phone}");
                                      },
                                      child: const Icon(
                                        Icons.call,
                                        color: Styles.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 18,
                                ),
                                GestureDetector(
                                  onTap: () async {},
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        _launchEmail(
                                            widget.clinic.email.toString(),
                                            "",
                                            "");
                                      },
                                      child: const Icon(
                                        Icons.mail,
                                        color: Styles.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite_border,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 30,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.clinic.clinicName.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.clinic.address.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ExpandableDescription(
                            description: "${widget.clinic.description}",
                          ),
                          // preview images
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Preview',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          Consumer<ClinicProvider>(
                            builder: (context, value, child) {
                              if (value.clinicAlbumLoading == true) {
                                return AppSpinner();
                              } else {
                                return SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.178,
                                  width: double.infinity,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: value.clinicAlbum.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: const EdgeInsets.only(
                                          right: 10,
                                        ),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.178,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              value.clinicAlbum[index].image
                                                  .toString(),
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          Consumer<ClinicProvider>(
                            builder: (context, value, child) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Reviews',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                  Text(
                                    value.numOfClinicReviews.toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    '( ${value.numOfClinicReviews.toString()})',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ClinicReviewsScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'See all',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Styles.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: Colors.grey[200],
                            padding: const EdgeInsets.only(
                              bottom: 10,
                              top: 10,
                            ),
                            child: Consumer<ClinicProvider>(
                              builder: (context, value, child) {
                                if (value.clinicReviewsLoading == true) {
                                  return AppSpinner();
                                } else {
                                  return SizedBox(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height *
                                        0.19,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: value.clinicReview.length,
                                        itemBuilder: (context, index) {
                                          print('$index');
                                          return SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            child: ReviewsContainer(
                                                clinicReview:
                                                    value.clinicReview[index]),
                                          );
                                        }),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future _launchEmail(String toEmail, String subject, String message) async {
    final url =
        "mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}";

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  Future _launchCaller(String phoneNumber) async {
    final url = "tel:$phoneNumber";

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
