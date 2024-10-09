import 'package:flutter/material.dart';
import 'package:tractian_test/core/theme/theme.dart';

class TextFieldFilterWidget extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  const TextFieldFilterWidget({
    super.key,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Buscar Ativo ou Local',
        hintStyle: TextStyle(
          color: ThemeTractian.textFieldColor,
        ),
        fillColor: ThemeTractian.boxColor,
        filled: true,
        prefixIcon: Icon(Icons.search, color: ThemeTractian.textFieldColor),
        contentPadding: EdgeInsets.symmetric(
          vertical: size.height * 0.01,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(
              size.height * 0.01,
            ),
          ),
        ),
      ),
    );
  }
}
