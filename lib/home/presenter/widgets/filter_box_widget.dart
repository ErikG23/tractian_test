// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/theme/theme.dart';

class FilterBoxWidget extends StatelessWidget {
  final bool isSelected;
  final String title;
  final Function() onTap;
  final String image;
  const FilterBoxWidget({
    super.key,
    required this.isSelected,
    required this.title,
    required this.onTap,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.006,
          horizontal: size.height * 0.01,
        ),
        decoration: BoxDecoration(
          color: isSelected ? ThemeTractian.primaryColor : ThemeTractian.white,
          borderRadius: BorderRadius.circular(
            size.height * 0.005,
          ),
          border: Border.all(
            width: 2,
            color: isSelected
                ? ThemeTractian.primaryColor
                : ThemeTractian.textFieldColor,
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              image,
              color: isSelected
                  ? ThemeTractian.greyLight
                  : ThemeTractian.textFieldColor,
            ),
            SizedBox(width: size.width * 0.014),
            Text(
              title,
              style: TextStyle(
                color: isSelected
                    ? ThemeTractian.white
                    : ThemeTractian.textFieldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
