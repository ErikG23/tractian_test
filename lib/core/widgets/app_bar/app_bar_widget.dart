import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tractian_test/core/theme/theme.dart';
import 'package:tractian_test/core/widgets/image/tractian_image_widget.dart';

class OxAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? tabName;
  const OxAppBarWidget({
    super.key,
    this.tabName,
  });

  @override
  Size get preferredSize => const Size.fromHeight(48);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final canPop = Navigator.canPop(context);

    final hasLeading = !canPop;

    return AppBar(
      backgroundColor: ThemeTractian.secondaryColor,
      title: tabName != null
          ? Text(
              '${tabName!} Unit',
              style: TextStyle(
                color: ThemeTractian.white,
              ),
            )
          : TractianImageWidget(
              width: size.width * 0.35,
            ),
      centerTitle: true,
      leading: hasLeading
          ? null
          : Builder(
              builder: (context) {
                return IconButton(
                  splashRadius: 14,
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: ThemeTractian.white,
                    size: 28,
                  ),
                  onPressed: () {
                    Modular.to.pop();
                  },
                );
              },
            ),
    );
  }
}
