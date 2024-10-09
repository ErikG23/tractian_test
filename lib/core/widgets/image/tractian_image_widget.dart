import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tractian_test/core/theme/images/images.dart';

class TractianImageWidget extends StatelessWidget {
  final double? height;
  final double? width;
  const TractianImageWidget({
    super.key,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      ImagesTractian.logo,
      width: width,
    );
  }
}
