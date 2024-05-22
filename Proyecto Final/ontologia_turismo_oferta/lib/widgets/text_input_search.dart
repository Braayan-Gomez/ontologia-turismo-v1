import 'package:flutter/material.dart';
import 'package:ontologia_turismo_oferta/providers/ontology_provider.dart';
import 'package:ontologia_turismo_oferta/theme/app_theme.dart';
import 'package:ontologia_turismo_oferta/widgets/text_input_widget.dart';

class TextInputSearchWiget extends StatelessWidget {
  const TextInputSearchWiget({
    super.key,
    required this.size,
    required this.ontologyProvider,
  });

  final Size size;
  final OntologyProvider ontologyProvider;

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 1,
      child: Padding(
        padding: EdgeInsets.only(
            top: size.height * 0.37,
            left: size.width / 12,
            right: size.width / 12),
        child: TextInputWidget(
            isSuffixIcon: true,
            suffixIcon: Icons.search,
            fillColor: AppTheme.customBackgroundColor,
            borderColor: AppTheme.customAppBarColor.withOpacity(0.1),
            borderbottomLeft: 50,
            borderbottomRight: 50,
            bordertopLeft: 50,
            bordertopRight: 50,
            labelTextColor: AppTheme.customTitleColor,
            labelText: '¿Qué estás buscando?',
            hintText: 'Hotel andinos plaza...',
            inputType: TextInputType.text,
            hintTextColor: Colors.grey.shade700,
            controler: ontologyProvider.textEditingController,
            onFieldSubmitted: (p0) {
              ontologyProvider.onRefresSearhData();
            }),
      ),
    );
  }
}

// ____________

// ____________

