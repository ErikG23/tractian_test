// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:tractian_test/home/domain/entities/tree_entity.dart';

import 'package:tractian_test/home/presenter/controllers/home_controller.dart';
import 'package:tractian_test/home/presenter/widgets/expansion_tile_custom_widget.dart';
import 'package:tractian_test/home/presenter/widgets/node_title_widget.dart';

class ListDataWidget extends StatefulWidget {
  final HomeController homeController;
  const ListDataWidget({
    super.key,
    required this.homeController,
  });

  @override
  State<ListDataWidget> createState() => _ListDataWidgetState();
}

class _ListDataWidgetState extends State<ListDataWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: ScopedBuilder(
        store: widget.homeController.store,
        onLoading: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
        onState: (context, state) {
          // Ordena os itens de forma que os que possuem filhos venham primeiro
          final sortedTreeNodes =
              List<TreeEntity>.from(widget.homeController.treeNodes);
          sortedTreeNodes.sort((a, b) {
            if (a.children.isNotEmpty && b.children.isEmpty) {
              return -1;
            } else if (a.children.isEmpty && b.children.isNotEmpty) {
              return 1;
            } else {
              return 0;
            }
          });

          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(top: 10),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final itemNode = sortedTreeNodes[index];
                      if (itemNode.children.isEmpty) {
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.05,
                          ),
                          title: NodeTitleWidget(
                            treeNode: itemNode,
                          ),
                        );
                      } else {
                        return ExpansionTileCustomWidget(
                          item: itemNode,
                        );
                      }
                    },
                    childCount: sortedTreeNodes.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
