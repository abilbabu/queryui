import 'package:flutter/material.dart';
import 'package:queryui/utils/ColorConstants.dart';
import 'package:queryui/utils/appstyle.dart';
import 'package:queryui/utils/imageconstants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.transparent,
      surfaceTintColor: ColorConstants.transparent,
      leading: const Padding(
        padding: EdgeInsets.all(10),
        child: SizedBox(
          height: 20,
          width: 20,
          child: Image(
            image: AssetImage(Imageconstants.drawer),
            color: ColorConstants.black,
          ),
        ),
      ),
      title: Center(
        child: Text(
          "Rick & Morty",
          style: Appstyle.getTextStyle(
            fontSize: 20,
            color: ColorConstants.black,
          ),
        ),
      ),
      actions: [
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: ColorConstants.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Padding(
            padding: EdgeInsets.all(5),
            child: Image(image: AssetImage(Imageconstants.profile)),
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
