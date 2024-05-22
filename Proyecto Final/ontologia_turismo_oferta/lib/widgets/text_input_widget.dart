import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget({
    super.key,
    this.hintText,
    required this.inputType,
    this.maxLines = 16,
    this.minLines = 1,
    this.labelText,
    this.initialValue,
    this.onChanged,
    this.onFieldSubmitted,
    this.bordertopLeft = 10,
    this.bordertopRight = 10,
    this.borderbottomRight = 10,
    this.borderbottomLeft = 10,
    this.onValidator = true,
    this.controler,
    this.onSaved,
    required this.borderColor,
    required this.fillColor,
    this.marginBootom = 15,
    this.minlengvalidator = 0,
    this.contentPaddingVertical = 17,
    this.autofocus = false,
    this.textInputAction,
    this.focusNode,
    this.scrollController,
    this.isPrefixIcon = false,
    this.prefixIcon,
    this.isSuffixIcon = false,
    this.suffixIcon,
    this.onTap,
    this.labelTextColor,
    this.hintTextColor,
    this.textStyleColor,
    this.enabled = true,
    this.contentPaddingleft = 15,
    this.contentPaddingrigth = 15,
    this.isTextCapitalization = true,
    this.isspace = true,
    this.isValidatorNameLastName,
    this.customizedDecoration,
    this.autovalidateMode,
  });

  final String? hintText;
  final String? labelText;
  final bool? isPrefixIcon;
  final IconData? prefixIcon;
  final bool? isSuffixIcon;
  final IconData? suffixIcon;
  final TextInputType inputType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final int? maxLines;
  final int? minLines;
  final String? initialValue;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Function(String?)? onSaved;
  final double? bordertopLeft;
  final double? bordertopRight;
  final double? borderbottomRight;
  final double? borderbottomLeft;
  final bool? onValidator;
  final bool? autofocus;
  final TextEditingController? controler;
  final Color borderColor;
  final Color fillColor;
  final double? marginBootom;
  final int? minlengvalidator;
  final double? contentPaddingVertical;
  final ScrollController? scrollController;
  final Function()? onTap;
  final Color? labelTextColor;
  final Color? hintTextColor;
  final Color? textStyleColor;
  final bool? enabled;
  final double? contentPaddingleft;
  final double? contentPaddingrigth;
  final bool? isTextCapitalization;
  final bool? isspace;
  final bool? isValidatorNameLastName;
  final Decoration? customizedDecoration;
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Container(
      margin: EdgeInsets.only(bottom: marginBootom!),
      decoration: customizedDecoration,
      child: TextFormField(
        enabled: enabled,
        onTap: onTap,
        scrollController: scrollController,
        inputFormatters: (inputType == TextInputType.number)
            ? [FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))]
            : (inputType == TextInputType.datetime)
                ? [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(?:[01]?\d|2[0-3])(?::(?:[0-5]\d?)?)?$'))
                  ]
                : (isspace == false)
                    ? [FilteringTextInputFormatter.deny(' ')]
                    : null,
        initialValue:
            (initialValue != null || initialValue != '') ? initialValue : null,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        onSaved: onSaved,
        autovalidateMode: autovalidateMode,
        controller: controler,
        focusNode: focusNode,
        autofocus: autofocus!,
        textCapitalization: (isTextCapitalization == true)
            ? TextCapitalization.sentences
            : TextCapitalization.none,
        textInputAction: textInputAction,
        keyboardType: inputType,
        maxLines: maxLines,
        minLines: minLines,
        style: TextStyle(
          height: 1,
          fontSize: 15 / textScaleFactor,
          fontFamily: 'Lato',
          color: (textStyleColor == null) ? Color(0xff767676) : textStyleColor,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          suffixIcon: (isSuffixIcon == true)
              ? Icon(
                  suffixIcon,
                  size: 20,
                )
              : null,
          prefixIcon: (isPrefixIcon == true)
              ? Icon(
                  prefixIcon,
                  size: 20,
                )
              : null,
          isDense: false,

          contentPadding: EdgeInsets.only(
              left: contentPaddingleft!,
              right: contentPaddingrigth!,
              bottom: contentPaddingVertical!,
              top: contentPaddingVertical!),
          filled: true,
          fillColor: fillColor,
          border: InputBorder.none,
          //------
          hintText: hintText,
          hintStyle: TextStyle(
              height: 1, color: hintTextColor, fontWeight: FontWeight.normal),
          //------

          //------
          labelText: labelText,
          labelStyle: TextStyle(
            color: labelTextColor,
            fontWeight: FontWeight.normal,
          ),
          floatingLabelStyle: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: labelTextColor),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          //-------

          errorStyle: const TextStyle(color: Colors.redAccent),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(bordertopLeft!),
                bottomLeft: Radius.circular(borderbottomLeft!),
                topRight: Radius.circular(bordertopRight!),
                bottomRight: Radius.circular(borderbottomRight!),
              )),

          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(bordertopLeft!),
                bottomLeft: Radius.circular(borderbottomLeft!),
                topRight: Radius.circular(bordertopRight!),
                bottomRight: Radius.circular(borderbottomRight!),
              )),

          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(bordertopLeft!),
                bottomLeft: Radius.circular(borderbottomLeft!),
                topRight: Radius.circular(bordertopRight!),
                bottomRight: Radius.circular(borderbottomRight!),
              )),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(bordertopLeft!),
                bottomLeft: Radius.circular(borderbottomLeft!),
                topRight: Radius.circular(bordertopRight!),
                bottomRight: Radius.circular(borderbottomRight!),
              )),

          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(bordertopLeft!),
                bottomLeft: Radius.circular(borderbottomLeft!),
                topRight: Radius.circular(bordertopRight!),
                bottomRight: Radius.circular(borderbottomRight!),
              )),
        ),
      ),
    );
  }
}
