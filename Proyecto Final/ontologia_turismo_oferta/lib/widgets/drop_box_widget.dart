import 'package:flutter/material.dart';
import 'package:ontologia_turismo_oferta/theme/app_theme.dart';

class DropdownButtonWidget extends StatelessWidget {
  final Function(String?)? onChanged;
  final String? value;
  final List<String>? categoryList;
  final String? labelText;
  final Function()? onTap;
  const DropdownButtonWidget({
    super.key,
    this.onChanged,
    this.value,
    this.categoryList,
    this.labelText,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    Color globalTeheme = AppTheme.customAppBarColor.withOpacity(0.1);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: DropdownButtonFormField(
        style: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: 15,
          fontFamily: 'Lato',
          color: AppTheme.customTitleColor,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
            labelText: labelText,
            errorStyle: const TextStyle(color: Colors.redAccent),
            floatingLabelStyle: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: AppTheme.customTitleColor),
            labelStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: AppTheme.customTitleColor),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: globalTeheme),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: globalTeheme),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: globalTeheme),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: globalTeheme),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: globalTeheme),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            filled: true,
            fillColor: AppTheme.customBackgroundColor),
        value: value,
        onChanged: onChanged,
        onTap: onTap,
        // elevation: 2,
        items: (categoryList != null)
            ? categoryList!.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    textScaler:
                        (value.length > 30) ? TextScaler.linear(0.9) : null,
                  ),
                );
              }).toList()
            : null,
      ),
    );
  }
}
