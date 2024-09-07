part of '../sdmx_model.dart';

class Data {
  const Data({
    required this.dataSets,
    required this.structures,
  });

  factory Data.fromJson(
    Map<String, dynamic> json,
  ) {
    final datasets = (json['dataSets'] as List)
        .map(
          (i) => DataSet.fromJson(i),
        )
        .toList();
    final structures = (json['structures'] as List)
        .map(
          (i) => Structure.fromJson(i),
        )
        .toList();
    return Data(
      dataSets: datasets,
      structures: structures,
    );
  }

  final List<DataSet> dataSets;
  final List<Structure> structures;

  @override
  String toString() => '_Data(dataSets: $dataSets, structures: $structures)';
}
