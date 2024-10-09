import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:tractian_test/core/widgets/app_bar/app_bar_widget.dart';
import 'package:tractian_test/home/domain/entities/company_entity.dart';
import 'package:tractian_test/home/presenter/controllers/home_controller.dart';
import 'package:tractian_test/home/presenter/widgets/filter_widget.dart';
import 'package:tractian_test/home/presenter/widgets/list_data_widget.dart';

class HomePage extends StatefulWidget {
  final HomeController homeController;
  final CompanyEntity company;

  const HomePage({
    super.key,
    required this.homeController,
    required this.company,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    widget.homeController.store.loadTreeNodes(widget.company.id);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => widget.homeController.clearData(),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OxAppBarWidget(
        tabName: widget.company.companyName,
      ),
      body: ScopedBuilder(
        store: widget.homeController.store,
        onState: (context, state) {
          return Column(
            children: [
              FilterWidget(
                homeController: widget.homeController,
              ),
              ListDataWidget(
                homeController: widget.homeController,
              )
            ],
          );
        },
      ),
    );
  }
}
