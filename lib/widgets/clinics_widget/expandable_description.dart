import 'package:flutter/material.dart';

class ExpandableDescription extends StatefulWidget {
  final String description;
  ExpandableDescription({Key? key, required this.description})
      : super(key: key);

  @override
  State<ExpandableDescription> createState() => _ExpandableDescriptionState();
}

class _ExpandableDescriptionState extends State<ExpandableDescription> {
  late String firstHalf;
  late String secondHalf;
  bool flag = true;

  @override
  void initState() {
    super.initState();
    if (widget.description.length > 100) {
      firstHalf = widget.description.substring(0, 100);
      secondHalf = widget.description.substring(100, widget.description.length);
    } else {
      flag = false;
      firstHalf = widget.description;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.length == ""
          ? Text(
              widget.description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  flag ? firstHalf + "..." : firstHalf + secondHalf,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                  child: secondHalf == ""
                      ? const SizedBox()
                      : Text(
                          firstHalf == ""
                              ? "No description"
                              : secondHalf == ""
                                  ? ""
                                  : flag
                                      ? "Read more"
                                      : "Read less",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),
                        ),
                ),
              ],
            ),
    );
  }
}
