part of '../sdmx_model.dart';

class DimensionValue {
  const DimensionValue({
    required this.id,
    required this.order,
    required this.start,
    required this.end,
    required this.name,
    required this.names,
  });

  factory DimensionValue.fromJson(
    Map<String, dynamic> json,
  ) =>
      DimensionValue(
        id: json['id'],
        order: json['order'],
        end: DateTime.tryParse(json['end'].toString()),
        start: DateTime.tryParse(json['start'].toString()),
        name: json['name'],
        names: Names.fromJson(json['names']),
      );

  final String id;
  final int? order;
  final DateTime? start;
  final DateTime? end;
  final String name;
  final Names names;

  @override
  String toString() {
    return 'DimensionValue(id: $id, order: $order, start: $start, end: $end, name: $name, names: $names)';
  }
}
