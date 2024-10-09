// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tractian_test/core/theme/images/images.dart';
import 'package:tractian_test/core/theme/theme.dart';
import 'package:tractian_test/home/domain/helpers/enums/type_item_enum.dart';
import 'package:tractian_test/home/domain/helpers/enums/type_state_enum.dart';

class DataHelper {
  static Widget getIconSensorItem(TypeItemEnum typeItem) {
    switch (typeItem) {
      case TypeItemEnum.asset:
        return SvgPicture.asset(
          ImagesTractian.asset,
          width: 25,
          height: 25,
          color: ThemeTractian.primaryColor,
        );
      case TypeItemEnum.location:
        return SvgPicture.asset(
          ImagesTractian.location,
          width: 25,
          height: 25,
          color: ThemeTractian.primaryColor,
        );
      case TypeItemEnum.component:
        return SvgPicture.asset(
          ImagesTractian.component,
          width: 25,
          height: 25,
          color: ThemeTractian.primaryColor,
        );
    }
  }

  static Widget getIconSensor(TypeSensorEnum typeState) {
    switch (typeState) {
      case TypeSensorEnum.critical:
        return SvgPicture.asset(
          ImagesTractian.critical,
          color: ThemeTractian.red,
          width: 12,
          height: 12,
        );
      case TypeSensorEnum.sensor:
        return SvgPicture.asset(
          ImagesTractian.bolt,
          color: ThemeTractian.green,
          width: 16,
          height: 16,
        );
    }
  }
}
