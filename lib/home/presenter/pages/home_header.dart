import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:tractian_test/core/theme/theme.dart';
import 'package:tractian_test/core/widgets/app_bar/app_bar_widget.dart';
import 'package:tractian_test/home/presenter/controllers/home_controller.dart';

class HomeHeader extends StatefulWidget {
  final HomeController homeController;
  const HomeHeader({
    super.key,
    required this.homeController,
  });

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  void initState() {
    super.initState();
    widget.homeController.fetchCompanies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          appBar: const OxAppBarWidget(),
          backgroundColor: ThemeTractian.white,
          body: ScopedBuilder(
            store: widget.homeController.store,
            onState: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.homeController.companies.length,
                      itemBuilder: (context, index) {
                        final company = widget.homeController.companies[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.05,
                            vertical: size.height * 0.025,
                          ),
                          child: GestureDetector(
                            onTap: () => Modular.to.pushNamed(
                              '/home',
                              arguments: {
                                'company': company,
                              },
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: ThemeTractian.primaryColor,
                                borderRadius: BorderRadius.circular(
                                  size.height * 0.01,
                                ),
                              ),
                              padding: EdgeInsets.all(size.height * 0.03),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.dashboard,
                                    color: ThemeTractian.white,
                                  ),
                                  SizedBox(width: size.width * 0.03),
                                  Expanded(
                                    child: Text(
                                      '${company.companyName} Unit',
                                      style: TextStyle(
                                        color: ThemeTractian.white,
                                        fontSize: size.height * 0.025,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }
}
