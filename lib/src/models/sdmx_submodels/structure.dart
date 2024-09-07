part of '../sdmx_model.dart';

/// holds properties of data points
class Structure {
  const Structure({
    required this.name,
    required this.names,
    required this.description,
    required this.descriptions,
    required this.dimensions,
    required this.attributes,
    required this.annotations,
    required this.dataSets,
  });

  factory Structure.fromJson(
    Map<String, dynamic> json,
  ) =>
      Structure(
        name: json['name'],
        names: Names.fromJson(json['names']),
        description: json['description'],
        descriptions: json['descriptions'] == null
            ? null
            : Names.fromJson(json['descriptions']),
        dimensions: Dimensions.fromJson(json['dimensions']),
        attributes: Attributes.fromJson(json['attributes']),
        annotations: (json['annotations'] as List)
            .map((i) => Annotation.fromJson(i))
            .toList(),
        dataSets: List<int>.from(json['dataSets']),
      );

  final String name;
  final Names names;
  final String? description;
  final Names? descriptions;
  final Dimensions dimensions;
  final Attributes attributes;
  final List<Annotation> annotations;
  final List<int> dataSets;

  @override
  String toString() {
    return 'Structure(name: $name, names: $names, description: $description, descriptions: $descriptions, dimensions: $dimensions, attributes: $attributes, annotations: $annotations, dataSets: $dataSets)';
  }
}
