import 'package:flutter/material.dart';

class BuildFainImageWidget extends StatelessWidget {
  const BuildFainImageWidget({
    super.key,
    required this.image,
    this.size,
  });

  final String image;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final temporalSize = MediaQuery.of(context).size;
    return FadeInImage(
      fit: BoxFit.cover,
      placeholderFit: BoxFit.scaleDown,
      placeholder: const AssetImage('assets/images/loading_2.gif'),
      image: NetworkImage(image),
      imageErrorBuilder: (context, url, error) {
        return Container(
            margin: (size != null)
                ? EdgeInsets.all(size! * 0.1)
                : EdgeInsets.all(temporalSize.height * 0.1),
            child: Image.asset(
              "assets/images/empty-box.png",
            ));
      },
    );
  }
}
