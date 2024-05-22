import 'dart:convert';
import 'dart:math';

class GeneralDataModel {
  Head? head;
  Results? results;

  GeneralDataModel({
    this.head,
    this.results,
  });

  factory GeneralDataModel.fromRawJson(String str) =>
      GeneralDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GeneralDataModel.fromJson(Map<String, dynamic> json) =>
      GeneralDataModel(
        head: json["head"] == null ? null : Head.fromJson(json["head"]),
        results:
            json["results"] == null ? null : Results.fromJson(json["results"]),
      );

  Map<String, dynamic> toJson() => {
        "head": head?.toJson(),
        "results": results?.toJson(),
      };
}

class Head {
  List<String>? vars;

  Head({
    this.vars,
  });

  factory Head.fromRawJson(String str) => Head.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Head.fromJson(Map<String, dynamic> json) => Head(
        vars: json["vars"] == null
            ? []
            : List<String>.from(json["vars"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "vars": vars == null ? [] : List<dynamic>.from(vars!.map((x) => x)),
      };
}

class Results {
  List<Binding>? bindings;

  Results({
    this.bindings,
  });

  factory Results.fromRawJson(String str) => Results.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        bindings: json["bindings"] == null
            ? []
            : List<Binding>.from(
                json["bindings"]!.map((x) => Binding.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bindings": bindings == null
            ? []
            : List<dynamic>.from(bindings!.map((x) => x.toJson())),
      };
}

class Binding {
  Direccion? nombre;
  Direccion? direccion;
  Direccion? valoracion;
  Direccion? type;
  String? imageUrl;

  Binding({
    this.nombre,
    this.direccion,
    this.valoracion,
    this.type,
    this.imageUrl,
  });

  factory Binding.fromRawJson(String str) => Binding.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Binding.fromJson(Map<String, dynamic> json) => Binding(
        nombre:
            json["nombre"] == null ? null : Direccion.fromJson(json["nombre"]),
        direccion: json["direccion"] == null
            ? null
            : Direccion.fromJson(json["direccion"]),
        valoracion: json["valoracion"] == null
            ? null
            : Direccion.fromJson(json["valoracion"]),
        type: json["type"] == null ? null : Direccion.fromJson(json["type"]),
        imageUrl: json['imageUrl'],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre?.toJson(),
        "direccion": direccion?.toJson(),
        "valoracion": valoracion?.toJson(),
        "type": type?.toJson(),
        "imageUrl": imageUrl,
      };
}

class Direccion {
  String? type;
  String? value;

  Direccion({
    this.type,
    this.value,
  });

  factory Direccion.fromRawJson(String str) =>
      Direccion.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Direccion.fromJson(Map<String, dynamic> json) => Direccion(
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "value": value,
      };
}
