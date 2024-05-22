import 'package:flutter/material.dart';
import 'package:ontologia_turismo_oferta/models/general_data.dart';
import 'package:ontologia_turismo_oferta/providers/ontology_provider.dart';
import 'package:ontologia_turismo_oferta/theme/app_theme.dart';
import 'package:ontologia_turismo_oferta/widgets/drop_box_widget.dart';
import 'package:ontologia_turismo_oferta/widgets/general_Image.dart';
import 'package:provider/provider.dart';

class QuickAccessBarCategories extends StatefulWidget {
  const QuickAccessBarCategories({
    super.key,
  });

  @override
  State<QuickAccessBarCategories> createState() =>
      _QuickAccessBarCategoriesState();
}

class _QuickAccessBarCategoriesState extends State<QuickAccessBarCategories> {
  double height = 100;

  @override
  Widget build(BuildContext context) {
    final OntologyProvider ontologyProvider =
        Provider.of<OntologyProvider>(context);

    return Container(
      decoration: AppTheme.customizedDecoration2,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // CAtegoria primaria
          FutureBuilder<Object>(
              future: ontologyProvider.principalCategoryVenue(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData || snapshot.hasError) {
                  return const SizedBox(
                    height: 50,
                    child: BuildFainImageWidget(
                      image: "",
                    ),
                  );
                }
                List<Binding> bindings = snapshot.data;

                List<String> list = bindings
                    .map((Binding binding) =>
                        binding.nombre!.value!.replaceAll("_", " "))
                    .toList();
                return DropdownButtonWidget(
                  labelText: "Categoria principal",
                  value: (ontologyProvider.firstCategory.isNotEmpty)
                      ? ontologyProvider.firstCategory
                      : null,
                  categoryList: list,
                  onChanged: (category) {
                    ontologyProvider.firstCategory = category!;
                    ontologyProvider.secondaryCategory = '';
                    ontologyProvider.thirdCategory = '';
                    ontologyProvider.globalCategory = category;
                    ontologyProvider.onRefresSearhData();
                  },
                );
              }),

          // categoria secundaria
          FutureBuilder<Object>(
              future: ontologyProvider
                  .otherCategoryVenue(ontologyProvider.firstCategory),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData || snapshot.hasError) {
                  return Container();
                }
                List<Binding> bindings = snapshot.data;

                List<String> list = bindings
                    .map((e) => e.nombre!.value!.replaceAll("_", " "))
                    .toList();

                if (list.isEmpty) {
                  return Container();
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: DropdownButtonWidget(
                      labelText: "Categoria secundaria",
                      value: (ontologyProvider.secondaryCategory.isNotEmpty)
                          ? ontologyProvider.secondaryCategory
                          : null,
                      categoryList: list,
                      onChanged: (category) {
                        ontologyProvider.secondaryCategory = category!;
                        ontologyProvider.thirdCategory = '';
                        ontologyProvider.globalCategory = category;
                        ontologyProvider.onRefresSearhData();
                      },
                    ),
                  );
                }
              }),

          // categoria terciaria
          FutureBuilder<Object>(
              future: ontologyProvider
                  .otherCategoryVenue(ontologyProvider.secondaryCategory),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData || snapshot.hasError) {
                  return Container();
                }
                List<Binding> bindings = snapshot.data;

                List<String> list = bindings
                    .map((e) => e.nombre!.value!.replaceAll("_", " "))
                    .toList();

                if (list.isEmpty) {
                  return Container();
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: DropdownButtonWidget(
                      labelText: "Categoria terciaria",
                      value: (ontologyProvider.thirdCategory.isNotEmpty)
                          ? ontologyProvider.thirdCategory
                          : null,
                      categoryList: list,
                      onChanged: (category) {
                        ontologyProvider.thirdCategory = category!;
                        ontologyProvider.globalCategory = category;
                        ontologyProvider.onRefresSearhData();
                      },
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
