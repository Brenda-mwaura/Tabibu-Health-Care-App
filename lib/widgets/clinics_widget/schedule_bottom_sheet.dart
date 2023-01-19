import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatelessWidget {
  final Widget formWidget;
  const ScheduleBottomSheet({Key? key, required this.formWidget})
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
        initialChildSize: 0.85,
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
            child: ListView(
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                formWidget
              ],
            ),
          );
        },
      ),
    );
  }
}
