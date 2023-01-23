import 'package:flutter/material.dart';
import 'package:tabibu/configs/styles.dart';

class ScheduleBottomSheet extends StatelessWidget {
  final Widget formWidget;
  final String? title;
  final double? initialHeight;
  const ScheduleBottomSheet(
      {Key? key,
      required this.formWidget,
      this.title,
      required this.initialHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _makeDismissible({required Widget child}) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );
    }

    return _makeDismissible(
      child: DraggableScrollableSheet(
        initialChildSize: initialHeight!.toDouble(),
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onHorizontalDragDown: (details) {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 0, bottom: 5),
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Styles.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    title.toString(),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: ListView(
                  shrinkWrap: true,
                  children: [
                    formWidget,
                  ],
                ))
              ],
            ),
          );
        },
      ),
    );
  }
}
