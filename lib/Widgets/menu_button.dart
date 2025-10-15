import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class MenuButton extends StatelessWidget {
  const MenuButton(this.table, this.icon,
      {super.key,
      this.bg = Colors.white,
      this.fg = Colors.black,
      required this.onTab});
  final String table;
  final IconData icon;
  final Color bg;
  final Color fg;
  final Function()? onTab;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            enableFeedback: false,
            backgroundColor: bg,
            foregroundColor: fg,
            shadowColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(radiusCircular(10)))),
        onPressed: onTab,
        child: Row(
          children: [
            Icon(
              icon,
              size: 50,
            ),
            const Gap(30),
            Text(
              table,
              style: Get.textTheme.headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold, color: fg),
            ),
          ],
        ).paddingSymmetric(horizontal: 0, vertical: 13));
  }
}
