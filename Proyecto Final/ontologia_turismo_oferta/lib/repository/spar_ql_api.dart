import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ontologia_turismo_oferta/models/general_data.dart';

class SparQLAPI {
  final Uri url = Uri.parse('http://10.0.2.2:3030/turismo/sparql');

  final String prefixQuery = '''
    PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
    PREFIX owl: <http://www.w3.org/2002/07/owl#>
    PREFIX OFERTA: <http://www.semanticweb.org/andre/ontologies/turismo/oferta#>
''';

  Future<String> ontologyFetchData(String sparqlQuery) async {
    http.Client client = http.Client();

    String query = prefixQuery + sparqlQuery;
    try {
      var response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept': 'application/json',
        },
        body: {'query': query},
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        log('Error: ${response.statusCode}');
        return 'Error: ${response.statusCode}';
      }
    } catch (e) {
      log('Error de conexión: $e');
      return 'Error de conexión: $e';
    } finally {
      client.close();
    }
  }

  Future<List<Binding>> searchVenue(
      {required String queryData, int? offset}) async {
    String query = '''
            SELECT ?nombre  
                  ?direccion 
                  (REPLACE(STR(?valoracion2), "^^<http://www.w3.org/2001/XMLSchema#double>", "") AS ?valoracion)
                  (strafter(str(?refType), "#") AS ?type)
            WHERE {
              ?x OFERTA:direccion ?direccion .
              ?x OFERTA:nombre ?nombre .
              ?x OFERTA:valoracion ?valoracion2 .
              ?x rdf:type ?refType .
              FILTER(
                ?refType != owl:NamedIndividual &&  #Filtro para excluir individuos sin tipo explícito
                (
                  regex(str(?nombre), "$queryData", "i") ||
                  regex(str(?valoracion), "$queryData", "i") ||
                  regex(str(?direccion), "$queryData", "i") ||
                  regex(str(?refType), "$queryData", "i")
                )
              ) 
            }
    ''';

    String pagination = "LIMIT 20 OFFSET $offset";
    if (offset != null) query += pagination;
    final String data = await ontologyFetchData(query);
    GeneralDataModel searshResponse = GeneralDataModel.fromRawJson(data);
    return searshResponse.results!.bindings!;
  }

  Future<List<Binding>> popularVenue() async {
    String query = '''
            SELECT ?nombre  
                  ?direccion 
                  (REPLACE(STR(?valoracion2), "^^<http://www.w3.org/2001/XMLSchema#double>", "") AS ?valoracion)
                  (strafter(str(?refType), "#") AS ?type)
            WHERE {
              ?x OFERTA:direccion ?direccion .
              ?x OFERTA:nombre ?nombre .
              ?x OFERTA:valoracion ?valoracion2 .
              ?x rdf:type ?refType .
              FILTER(
                ?refType != owl:NamedIndividual &&  #Filtro para excluir individuos sin tipo explícito
                (?valoracion2 > 4.5)
              ) 
            }
    ''';
    final data = await ontologyFetchData(query);
    GeneralDataModel searshResponse = GeneralDataModel.fromRawJson(data);
    return searshResponse.results!.bindings!;
  }

  Future<List<Binding>> principalCategoryVenue() async {
    String query = '''
          SELECT 
          (strafter(str(?x), "#") AS ?nombre)
          WHERE {
          ?x rdf:type owl:Class .
          FILTER NOT EXISTS { ?x rdfs:subClassOf ?superclass }
          FILTER(STRSTARTS(STR(?x), STR(OFERTA:)))
          }
    ''';
    final data = await ontologyFetchData(query);
    GeneralDataModel searshResponse = GeneralDataModel.fromRawJson(data);
    return searshResponse.results!.bindings!;
  }

  Future<List<Binding>> otherCategoryVenue(String category) async {
    String categoryNormalised = category.replaceAll(" ", "_");
    String query = '''
            SELECT (strafter(str(?x), "#") AS ?nombre) WHERE {
            ?x rdfs:subClassOf OFERTA:$categoryNormalised .
            }
    ''';
    final data = await ontologyFetchData(query);
    GeneralDataModel searshResponse = GeneralDataModel.fromRawJson(data);
    return searshResponse.results!.bindings!;
  }

  Future<List<Binding>> searchCategoryAndQueryData(
      {String? category = "", String? search = "", int? offset}) async {
    String categoryNormalised = category!.replaceAll(" ", "_");
    log(categoryNormalised.toString());
    String query = '''
          SELECT 
                ?nombre  
                ?direccion 
                (REPLACE(STR(?valoracion2), "^^<http://www.w3.org/2001/XMLSchema#double>", "") AS ?valoracion)
                (strafter(str(?refType), "#") AS ?type) 
          WHERE {
                ?refType rdfs:subClassOf* OFERTA:$categoryNormalised .
                ?x rdf:type ?refType .
                ?x OFERTA:nombre ?nombre .
                ?x OFERTA:direccion ?direccion .
                ?x OFERTA:valoracion ?valoracion2 .
          FILTER(
                regex(str(?nombre), "$search", "i") ||
                regex(str(?valoracion), "$search", "i") ||
                regex(str(?direccion), "$search", "i") ||
                regex(str(?refType), "$search", "i")
                ) 
          }
          ORDER BY ?refType
         
    ''';
    String pagination = "LIMIT 20 OFFSET $offset";
    if (offset != null) query += pagination;

    final data = await ontologyFetchData(query);
    GeneralDataModel searshResponse = GeneralDataModel.fromRawJson(data);
    return searshResponse.results!.bindings!;
  }
}
