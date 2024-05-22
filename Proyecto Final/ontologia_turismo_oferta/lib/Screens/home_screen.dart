import 'dart:async';

import 'package:flutter/material.dart';

import 'package:ontologia_turismo_oferta/providers/ontology_provider.dart';
import 'package:ontologia_turismo_oferta/search/search_delegate.dart';
import 'package:ontologia_turismo_oferta/theme/app_theme.dart';
import 'package:ontologia_turismo_oferta/widgets/elevation_buttom_scroll.dart';
import 'package:ontologia_turismo_oferta/widgets/build_carousel_slider.dart';
import 'package:ontologia_turismo_oferta/widgets/quick_access_bar_ategories.dart';
import 'package:ontologia_turismo_oferta/widgets/text_input_search.dart';
import 'package:ontologia_turismo_oferta/widgets/venues_list_widget.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OntologyProvider ontologyProvider =
        Provider.of<OntologyProvider>(context);
    return HomeScreenT(ontologyProvider: ontologyProvider);
  }
}

class HomeScreenT extends StatefulWidget {
  const HomeScreenT({super.key, required this.ontologyProvider});
  final OntologyProvider ontologyProvider;

  @override
  State<HomeScreenT> createState() => _HomeScreenTState();
}

class _HomeScreenTState extends State<HomeScreenT> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  late ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;
  bool _isButtomTop = false;

  @override
  void initState() {
    widget.ontologyProvider.onRefresSearhData();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;

      if (_scrollPosition >= 274) {
        _isButtomTop = true;
      } else {
        _isButtomTop = false;
      }
    });
  }

  void _onLoading() async {
    await Future.delayed(const Duration(seconds: 2));
    await widget.ontologyProvider.onLoadingSearhData();
    if (mounted) setState(() {});

    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < size.height * 0.35
        ? _scrollPosition / (size.height * 0.35)
        : 1;

    final OntologyProvider ontologyProvider =
        Provider.of<OntologyProvider>(context);
    return Scaffold(
      backgroundColor: AppTheme.customBackgroundColor,
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButtonScroll(
          isButtomTop: _isButtomTop, scrollController: _scrollController),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0), // Altura del AppBar
        child: _BuildAppBar(
            opacity: _opacity, size: size, ontologyProvider: ontologyProvider),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: false,
        enablePullUp: true,
        header: const WaterDropMaterialHeader(
          backgroundColor: Color(0xFF004F51),
        ),
        footer: const ClassicFooter(
          height: 80,
        ),
        onLoading: _onLoading,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // BODY
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Stack(
                    children: [
                      PopularVenuesCarousel(
                        ontologyProvider: ontologyProvider,
                      ),
                      TextInputSearchWiget(
                          size: size, ontologyProvider: ontologyProvider),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  )
                ],
              ),
            ),
            const CardVenues()
          ],
        ),
      ),
    );
  }
}

class _BuildAppBar extends StatelessWidget {
  const _BuildAppBar({
    super.key,
    required double opacity,
    required this.size,
    required this.ontologyProvider,
  }) : _opacity = opacity;

  final double _opacity;
  final Size size;
  final OntologyProvider ontologyProvider;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(15),
        bottomRight: Radius.circular(15),
      ),
      child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Stack(
          children: [
            AppBar(
              backgroundColor: AppTheme.customAppBarColor.withOpacity(_opacity),
              elevation: 0,
              centerTitle: true,
              actions: [
                if (_opacity == 1)
                  IconButton(
                    color: AppTheme.customBackgroundColor,
                    icon: const Icon(Icons.search_outlined),
                    onPressed: () {
                      showSearch(
                          context: context, delegate: OntologySearchDelegate());
                    },
                  ),
              ],
              title: const Text(
                'SEGITTUR',
                style: TextStyle(
                  color: AppTheme.customBackgroundColor,
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 3,
                ),
              ),
              automaticallyImplyLeading: true,
            ),
            Positioned(
              bottom: 10,
              child: SizedBox(
                height: 40,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        showPopover(
                          context: context,
                          bodyBuilder: (context) =>
                              const QuickAccessBarCategories(),
                          direction: PopoverDirection.bottom,
                          width: size.width * 0.90,
                          barrierColor: Colors.transparent,
                          arrowHeight: 10,
                          arrowWidth: 10,
                          arrowDxOffset: -172,
                          arrowDyOffset: -10,
                        );
                      },
                      icon: const Icon(
                        Icons.filter_alt,
                        color: AppTheme.customBackgroundColor,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          ontologyProvider.clearFilter();
                        },
                        icon: const Icon(
                          Icons.cleaning_services,
                          color: AppTheme.customBackgroundColor,
                        ))
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
