import 'package:flutter/material.dart';
import 'package:tractian_test/home/presenter/widgets/node_title_widget.dart';
import '../../domain/entities/tree_entity.dart';

class ExpansionTileCustomWidget extends StatelessWidget {
  final TreeEntity item;
  const ExpansionTileCustomWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Ordena os filhos para que itens com children apareçam primeiro
    final sortedChildren = List<TreeEntity>.from(item.children);
    sortedChildren.sort((a, b) {
      if (a.children.isNotEmpty && b.children.isEmpty) {
        return -1;
      } else if (a.children.isEmpty && b.children.isNotEmpty) {
        return 1;
      } else {
        return 0;
      }
    });

    return ExpansionTile(
      controlAffinity: ListTileControlAffinity.leading,
      tilePadding: EdgeInsets.symmetric(horizontal: size.width * 0.005),
      visualDensity: VisualDensity.compact,
      childrenPadding: EdgeInsets.only(
        left: size.width * 0.05,
      ),
      leading: item.children.isEmpty ? const SizedBox(width: 50) : null,
      dense: false,
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.transparent,
        ),
      ),
      title: NodeTitleWidget(
        treeNode: item,
      ),
      children: sortedChildren.map((childItem) {
        if (childItem.children.isEmpty) {
          return ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1,
            ),
            title: NodeTitleWidget(
              treeNode: item,
            ),
          );
        } else {
          return ExpansionTileCustomWidget(
            item: childItem,
          );
        }
      }).toList(),
    );
  }
}
