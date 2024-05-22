import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:ontologia_turismo_oferta/helpers/debounce.dart';
import 'package:ontologia_turismo_oferta/models/general_data.dart';
import 'package:ontologia_turismo_oferta/repository/spar_ql_repository.dart';

class OntologyProvider extends ChangeNotifier {
  final SparQLRepository _sparQLRepository = SparQLRepository();
  TextEditingController textEditingController = TextEditingController(text: "");
// ______________________________________

// first category, second category, third category
  List<Binding> _newResult = [];
  int _offSet = 0;

// importante
  List<Binding> get newResult => _newResult;
  set newResult(List<Binding> value) {
    _newResult = value;
    notifyListeners();
  }

  String _globalCategory = "";
  String get globalCategory => _globalCategory;
  set globalCategory(String value) {
    _globalCategory = value;
    notifyListeners();
  }

  String _firstCategory = "";
  String get firstCategory => _firstCategory;
  set firstCategory(String value) {
    _firstCategory = value;
    notifyListeners();
  }

  String _secondCategory = "";
  String get secondaryCategory => _secondCategory;
  set secondaryCategory(String value) {
    _secondCategory = value;
    notifyListeners();
  }

  String _thirdCategory = "";
  String get thirdCategory => _thirdCategory;
  set thirdCategory(String value) {
    _thirdCategory = value;
    notifyListeners();
  }

// ______________________________________
  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );
  final StreamController<List<Binding>> _suggestionStreamController =
      StreamController.broadcast();

  Stream<List<Binding>> get suggestionStream =>
      _suggestionStreamController.stream;

  String get getimageUrl {
    var random = math.Random();
    int randomNumer = random.nextInt(200);
    return 'https://picsum.photos/500/400?image=$randomNumer';
  }

  void getSuggestionsQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      List<Binding> results = await searchVenue(queryData: value);
      _suggestionStreamController.add(results);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(const Duration(milliseconds: 301))
        .then((_) => timer.cancel());
  }
// ______________________________________

  Future<List<Binding>> searchVenue({required String queryData, int? offset}) =>
      _sparQLRepository.searchVenueRepository(
          queryData: queryData, offset: offset);

  Future<List<Binding>> popularVenue() =>
      _sparQLRepository.popularVenueRepository();

  Future<List<Binding>> principalCategoryVenue() =>
      _sparQLRepository.principalCategoryVenueRepository();

  Future<List<Binding>> otherCategoryVenue(String category) =>
      _sparQLRepository.otherCategoryVenueRepository(category);

  Future<List<Binding>> searchCategoryAndQueryData(
          {String? category = "", String? search = "", int? offset}) =>
      _sparQLRepository.searchCategoryAndQueryDataRepository(
          category: category, search: search, offset: offset);

  void _getImages() {
    for (var i = _offSet; i < newResult.length; i++) {
      Binding binding = newResult[i];
      binding.imageUrl = getimageUrl;
    }
  }

  void clearFilter() {
    firstCategory = "";
    secondaryCategory = "";
    thirdCategory = "";
    globalCategory = "";
    textEditingController.clear();
    onRefresSearhData();
  }

  Future<void> onRefresSearhData() async {
    newResult.clear();
    _offSet = 0;
    if (globalCategory.isNotEmpty) {
      // para cuando tengo alguna categoria seleccinada
      newResult = await searchCategoryAndQueryData(
          category: globalCategory,
          search: textEditingController.text,
          offset: _offSet);
    } else {
      // para cuando no tengo ninguna categoria seleccionada
      newResult = await searchVenue(
          queryData: textEditingController.text, offset: _offSet);
    }
    _getImages();
    notifyListeners();
  }

  Future<void> onLoadingSearhData() async {
    _offSet += 20;
    List<Binding> temporalNewResult = [];
    if (globalCategory.isNotEmpty) {
      temporalNewResult = await searchCategoryAndQueryData(
          category: globalCategory,
          search: textEditingController.text,
          offset: _offSet);
    } else {
      temporalNewResult = await searchVenue(
          queryData: textEditingController.text, offset: _offSet);
    }
    newResult.addAll(temporalNewResult);
    _getImages();
    notifyListeners();
  }
}
