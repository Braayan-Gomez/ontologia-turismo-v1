import 'package:flutter/material.dart';
import 'package:ontologia_turismo_oferta/models/general_data.dart';
import 'package:ontologia_turismo_oferta/providers/ontology_provider.dart';
import 'package:ontologia_turismo_oferta/theme/app_theme.dart';
import 'package:ontologia_turismo_oferta/widgets/general_Image.dart';
import 'package:provider/provider.dart';

class OntologySearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar lugar';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    Color colorWhite = AppTheme.customBackgroundColor;
    return Theme.of(context).copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: AppTheme.customAppBarColor,
          iconTheme: IconThemeData(color: colorWhite),
          toolbarTextStyle: TextStyle(color: colorWhite),
          titleTextStyle: TextStyle(color: colorWhite, fontSize: 20),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: colorWhite),
        ),
        textTheme: TextTheme(
          headline6: TextStyle(color: colorWhite),
        ),
        scaffoldBackgroundColor: AppTheme.customBackgroundColor);
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return _empyContaine();
    }
    final ontologyProvider =
        Provider.of<OntologyProvider>(context, listen: false);
    ontologyProvider.getSuggestionsQuery(query);
    return StreamBuilder(
        stream: ontologyProvider.suggestionStream,
        builder: (_, AsyncSnapshot<List<Binding>> snapshot) {
          if (!snapshot.hasData) return _empyContaine();

          final data = snapshot.data!;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, int index) => _Binding(
              ontologyProvider: ontologyProvider,
              lugar: data[index],
            ),
          );
        });
  }

  Widget _empyContaine() {
    return const Center(
        child: Icon(
      Icons.holiday_village,
      color: Colors.black38,
      size: 100,
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _empyContaine();
    }
    final ontologyProvider =
        Provider.of<OntologyProvider>(context, listen: false);
    ontologyProvider.getSuggestionsQuery(query);
    return StreamBuilder(
        stream: ontologyProvider.suggestionStream,
        builder: (_, AsyncSnapshot<List<Binding>> snapshot) {
          if (!snapshot.hasData) return _empyContaine();

          final data = snapshot.data!;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, int index) => _Binding(
              ontologyProvider: ontologyProvider,
              lugar: data[index],
            ),
          );
        });
  }
}

class _Binding extends StatelessWidget {
  final Binding lugar;
  final OntologyProvider ontologyProvider;

  const _Binding(
      {super.key, required this.lugar, required this.ontologyProvider});

  getimageData() {}
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipOval(
          child: Container(
              height: 80,
              width: 80,
              child: BuildFainImageWidget(
                image: ontologyProvider.getimageUrl,
                size: 80,
              ))),
      title: Text(lugar.nombre!.value!),
      subtitle: Text(
        lugar.direccion!.value!,
        style: TextStyle(fontSize: 13),
      ),
      trailing: SizedBox(
          width: 80, child: Text(lugar.type!.value!.replaceAll("_", " "))),
      onTap: () {},
    );
  }
}
