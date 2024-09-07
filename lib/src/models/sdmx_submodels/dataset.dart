part of '../sdmx_model.dart';

class DataSet {
  const DataSet({
    required this.structure,
    required this.action,
    required this.links,
    required this.annotations,
    required this.observations,
  });

  factory DataSet.fromJson(
    Map<String, dynamic> json,
  ) =>
      DataSet(
        structure: json['structure'],
        action: json['action'],
        links: (json['links'] as List).map((i) => Link.fromJson(i)).toList(),
        annotations: List<int>.from(json['annotations']),
        observations: Map<String, List<dynamic>>.from(json['observations']),
      );

  final int structure;
  final String action;
  final List<Link> links;
  final List<int> annotations;
  final Map<String, List<dynamic>> observations;

  @override
  String toString() {
    return 'DataSet(structure: $structure, action: $action, links: $links, annotations: $annotations, observations: $observations)';
  }
}
