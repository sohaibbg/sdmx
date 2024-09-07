part of '../sdmx_model.dart';

class Attributes {
  const Attributes({
    required this.dataSet,
    required this.dimensionGroup,
    required this.series,
    required this.observation,
  });

  factory Attributes.fromJson(
    Map<String, dynamic> json,
  ) =>
      Attributes(
        dataSet: List<dynamic>.from(json['dataSet']),
        dimensionGroup: List<dynamic>.from(json['dimensionGroup']),
        series: List<dynamic>.from(json['series']),
        observation: (json['observation'] as List)
            .map((i) => ObservationAttribute.fromJson(i))
            .toList(),
      );

  final List<dynamic> dataSet;
  final List<dynamic> dimensionGroup;
  final List<dynamic> series;
  final List<ObservationAttribute> observation;

  @override
  String toString() {
    return 'Attributes(dataSet: $dataSet, dimensionGroup: $dimensionGroup, series: $series, observation: $observation)';
  }
}
