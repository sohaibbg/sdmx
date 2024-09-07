part of '../sdmx_model.dart';

class Dimensions {
  const Dimensions({
    required this.dataSet,
    required this.series,
    required this.observation,
  });

  factory Dimensions.fromJson(
    Map<String, dynamic> json,
  ) =>
      Dimensions(
        dataSet: List<dynamic>.from(json['dataSet']),
        series: List<dynamic>.from(json['series']),
        observation: (json['observation'] as List)
            .map((i) => ObservationDimension.fromJson(i))
            .toList(),
      );
  final List<dynamic> dataSet;
  final List<dynamic> series;
  final List<ObservationDimension> observation;

  @override
  String toString() =>
      '_Dimensions(dataSet: $dataSet, series: $series, observation: $observation)';
}
