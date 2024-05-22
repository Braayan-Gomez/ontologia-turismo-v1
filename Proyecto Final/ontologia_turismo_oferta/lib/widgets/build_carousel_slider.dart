import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ontologia_turismo_oferta/models/general_data.dart';
import 'package:ontologia_turismo_oferta/providers/ontology_provider.dart';
import 'package:ontologia_turismo_oferta/theme/app_theme.dart';
import 'package:ontologia_turismo_oferta/widgets/general_Image.dart';

class PopularVenuesCarousel extends StatefulWidget {
  final OntologyProvider ontologyProvider;
  const PopularVenuesCarousel({super.key, required this.ontologyProvider});

  @override
  State<PopularVenuesCarousel> createState() => _PopularVenuesCarouselState();
}

class _PopularVenuesCarouselState extends State<PopularVenuesCarousel>
    with AutomaticKeepAliveClientMixin {
  final String imagePath = 'assets/images/';

  final CarouselController _controller = CarouselController();

  List<Binding> bindings = [];
  List<String> images = [];
  int _current = 0;

  @override
  void initState() {
    fechData();
    super.initState();
  }

  Future<void> fechData() async {
    bindings = await widget.ontologyProvider.popularVenue();

    for (var i = 0; i < bindings.length; i++) {
      images.add(widget.ontologyProvider.getimageUrl);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
      child: SizedBox(
        height: 355,
        child: Stack(
          children: [
            if (bindings.isNotEmpty)
              CarouselSlider.builder(
                itemCount: bindings.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  Binding bindingData = bindings[itemIndex];
                  // log(bindingData.nombre!.value!.toString());
                  return SizedBox(
                    width: size.width,
                    child: GestureDetector(
                      onTap: () {},
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: BuildFainImageWidget(
                              image: images[itemIndex],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                gradient: AppTheme.linearGradient),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.1),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Text(
                                    bindingData.nombre!.value!,
                                    style: TextStyle(
                                      letterSpacing: 8,
                                      fontFamily: 'Electrolize',
                                      fontSize: size.width / 25,
                                      fontWeight: FontWeight.w500,
                                      color: AppTheme.customBackgroundColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Stack(
                                    children: [
                                      const Center(
                                        child: Icon(
                                          Icons.star_outlined,
                                          size: 60,
                                          color: AppTheme.customBackgroundColor,
                                        ),
                                      ),
                                      Positioned.fill(
                                        top: 5,
                                        child: Center(
                                          child: Text(
                                            bindingData.valoracion!.value!
                                                .substring(0, 3),
                                            style: TextStyle(
                                                letterSpacing: 0,
                                                fontFamily: 'Electrolize',
                                                fontSize: size.width / 30,
                                                color:
                                                    AppTheme.customTitleColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                    initialPage: 0,
                    height: 360,
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
                carouselController: _controller,
              )
            else ...[
              const BuildFainImageWidget(image: "image"),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black45, Colors.transparent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
