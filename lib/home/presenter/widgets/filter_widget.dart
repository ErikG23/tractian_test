// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tractian_test/core/theme/images/images.dart';

import 'package:tractian_test/home/presenter/controllers/home_controller.dart';
import 'package:tractian_test/home/presenter/widgets/text_field_filter_widget.dart';
import 'package:tractian_test/home/presenter/widgets/filter_box_widget.dart';

class FilterWidget extends StatefulWidget {
  final HomeController homeController;
  const FilterWidget({
    super.key,
    required this.homeController,
  });

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.02,
        horizontal: size.width * 0.05,
      ),
      child: Column(
        children: [
          TextFieldFilterWidget(
            onChanged: (query) {
              widget.homeController.updateSearchQuery(query);
            },
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            children: [
              FilterBoxWidget(
                isSelected: widget.homeController.isSensorSelected,
                title: 'Sensor de Energia',
                onTap: () => widget.homeController.toggleSensorSelection(),
                image: ImagesTractian.bolt,
              ),
              SizedBox(width: size.width * 0.014),
              FilterBoxWidget(
                isSelected: widget.homeController.isAlertSelected,
                title: 'Crítico',
                onTap: () => widget.homeController.toggleAlertSelection(),
                image: ImagesTractian.critical,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
