import 'package:flutter/material.dart';
import 'package:ontologia_turismo_oferta/theme/app_theme.dart';

class FloatingActionButtonScroll extends StatelessWidget {
  const FloatingActionButtonScroll({
    super.key,
    required this.scrollController,
    required this.isButtomTop,
  });
  final ScrollController scrollController;
  final bool isButtomTop;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isButtomTop)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.customAppBarColor,
              shape: const CircleBorder(),
            ),
            child: const Icon(
              Icons.arrow_upward,
              color: Colors.white,
            ),
            onPressed: () {
              if (scrollController.hasClients) {
                final position = scrollController.position.minScrollExtent;
                scrollController.animateTo(
                  position,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeOut,
                );
              }
            },
          ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.customAppBarColor,
            shape: const CircleBorder(),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            if (scrollController.hasClients) {
              final position = scrollController.position.minScrollExtent;
              scrollController.animateTo(
                position,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeOut,
              );
            }
          },
        ),
      ],
    );
  }
}
