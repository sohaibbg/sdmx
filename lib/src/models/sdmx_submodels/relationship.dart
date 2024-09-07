part of '../sdmx_model.dart';

class Relationship {
  const Relationship({
    required this.observation,
    required this.dimensions,
  });

  factory Relationship.fromJson(
    Map<String, dynamic> json,
  ) =>
      Relationship(
        observation: json['observation'] == null
            ? null
            : Map<String, dynamic>.from(json['observation']),
        dimensions: json['dimensions'] == null
            ? null
            : List<String>.from(json['dimensions']),
      );

  final Map<String, dynamic>? observation;
  final List<String>? dimensions;

  @override
  String toString() =>
      '_Relationship(observation: $observation, dimensions: $dimensions)';
}
