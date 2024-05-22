import 'package:flutter/material.dart';
import 'package:ontologia_turismo_oferta/theme/app_theme.dart';

class ExpansionPanelWidget extends StatefulWidget {
  final bool? isPadding;
  final Widget widget;
  final String title;
  final bool? isEdit;
  final bool? iseditingvalue;
  const ExpansionPanelWidget({
    super.key,
    required this.title,
    required this.widget,
    this.isPadding = true,
    this.isEdit,
    this.iseditingvalue,
  });

  @override
  State<ExpansionPanelWidget> createState() => _ExpansionPanelWidgetState();
}

class _ExpansionPanelWidgetState extends State<ExpansionPanelWidget> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.customizedDecoration1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _isExpanded = isExpanded;
            });
          },
          children: <ExpansionPanel>[
            ExpansionPanel(
                backgroundColor: Colors.transparent,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontFamily: 'Lato',
                        color: AppTheme.customTitleColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
                body: Padding(
                  padding: (widget.isPadding == true)
                      ? const EdgeInsets.only(right: 20, left: 20, bottom: 20)
                      : const EdgeInsets.only(bottom: 20),
                  child: widget.widget,
                ),
                isExpanded: _isExpanded,
                canTapOnHeader: _isExpanded)
          ],
          elevation: 0,
        ),
      ),
    );
  }
}
