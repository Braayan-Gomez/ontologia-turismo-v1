import 'package:ontologia_turismo_oferta/models/general_data.dart';
import 'package:ontologia_turismo_oferta/repository/spar_ql_api.dart';

class SparQLRepository {
  final _sparQLAPI = SparQLAPI();

  Future<List<Binding>> searchVenueRepository(
          {required String queryData, int? offset}) =>
      _sparQLAPI.searchVenue(queryData: queryData, offset: offset);

  Future<List<Binding>> popularVenueRepository() => _sparQLAPI.popularVenue();

  Future<List<Binding>> principalCategoryVenueRepository() =>
      _sparQLAPI.principalCategoryVenue();

  Future<List<Binding>> otherCategoryVenueRepository(String category) =>
      _sparQLAPI.otherCategoryVenue(category);

  Future<List<Binding>> searchCategoryAndQueryDataRepository(
          {String? category = "", String? search = "", int? offset}) =>
      _sparQLAPI.searchCategoryAndQueryData(
          category: category, search: search, offset: offset);
}
