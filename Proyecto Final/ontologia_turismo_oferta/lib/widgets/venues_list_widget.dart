import 'package:flutter/material.dart';
import 'package:ontologia_turismo_oferta/metodos_globales/metodos_globales.dart';
import 'package:ontologia_turismo_oferta/models/general_data.dart';
import 'package:ontologia_turismo_oferta/providers/ontology_provider.dart';
import 'package:ontologia_turismo_oferta/theme/app_theme.dart';
import 'package:ontologia_turismo_oferta/widgets/general_Image.dart';
import 'package:provider/provider.dart';

class CardVenues extends StatelessWidget {
  const CardVenues({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final OntologyProvider ontologyProvider =
        Provider.of<OntologyProvider>(context);
    final size = MediaQuery.of(context).size;
    if (ontologyProvider.newResult.isNotEmpty) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            Binding binding = ontologyProvider.newResult[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: AppTheme.customizedDecoration1,
              child: Card(
                color: Colors.transparent,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                              bottom: Radius.circular(10)),
                          child: SizedBox(
                            height: 200,
                            width: size.width,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: BuildFainImageWidget(
                                    image: binding.imageUrl ?? "",
                                    size: 200,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      gradient: AppTheme.linearGradient2),
                                ),
                                const Positioned(
                                    top: 10,
                                    right: 10,
                                    child: Icon(
                                      Icons.star,
                                      size: 45,
                                      color: AppTheme.customBackgroundColor,
                                    )),
                                Positioned(
                                  top: 26,
                                  right: 25,
                                  child: Text(
                                    binding.valoracion!.value!.substring(0, 3),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        letterSpacing: -1,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.customiInfoColor),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  left: 10,
                                  child: Text(
                                    binding.type!.value!.replaceAll("_", " "),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w500,
                                        color: AppTheme.customBackgroundColor),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            binding.nombre!.value!.toString(),
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color: AppTheme.customiInfoColor),
                          ),
                          Text(
                            obtenerTextoDespuesDePenultimaComa(
                                binding.direccion!.value!),
                            style: const TextStyle(
                                fontSize: 13,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color: AppTheme.customiInfoColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          childCount: ontologyProvider.newResult.length,
        ),
      );
    } else {
      return SliverList(
        delegate: SliverChildListDelegate(
          [
            Container(
                padding: const EdgeInsets.all(70),
                child: const BuildFainImageWidget(image: ""))
          ],
        ),
      );
    }
  }
}
