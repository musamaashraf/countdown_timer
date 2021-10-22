import 'package:countdown_timer/style/colors.dart';
import 'package:flutter/material.dart';

class CommonStyles {
  Widget customButton(
      {required BuildContext context,
      required void Function()? onTap,
      required String text}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Palette.primary,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
                color: Palette.grey.withOpacity(0.4),
                offset: const Offset(0.0, 4.0),
                blurRadius: 12.0),
          ],
        ),
        width: MediaQuery.of(context).size.width * 0.50,
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 22.0),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: Palette.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget tileButton(
      {required BuildContext context,
      required void Function()? onTap,
      required String text}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Palette.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
                color: Palette.grey.withOpacity(0.4),
                offset: const Offset(0.0, 4.0),
                blurRadius: 12.0),
          ],
          border: Border.all(
            color: Palette.grey.withOpacity(0.8),
          ),
        ),
        width: MediaQuery.of(context).size.width * 0.38,
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 22.0),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: Palette.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
