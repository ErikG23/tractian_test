import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tractian_test/home/domain/entities/tree_entity.dart';
import '../../domain/helpers/data_helper/data_helper.dart';

class NodeTitleWidget extends StatelessWidget {
  final TreeEntity treeNode;

  const NodeTitleWidget({
    super.key,
    required this.treeNode,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = MediaQuery.of(context).size.height * 0.016;
    final iconSpacing = screenWidth * 0.02;

    return Row(
      children: [
        DataHelper.getIconSensorItem(treeNode.item.typeItem),
        SizedBox(width: iconSpacing),
        Flexible(
          child: Text(
            treeNode.item.name,
            style: TextStyle(
              fontSize: fontSize,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: iconSpacing),
        if (treeNode.item.status != null)
          DataHelper.getIconSensor(treeNode.item.status!),
      ],
    );
  }
}
