part of '../sdmx_model.dart';

class ObservationDimension {
  const ObservationDimension({
    required this.id,
    required this.name,
    required this.names,
    required this.keyPosition,
    required this.roles,
    required this.values,
  });

  factory ObservationDimension.fromJson(
    Map<String, dynamic> json,
  ) =>
      ObservationDimension(
        id: json['id'],
        name: json['name'],
        names: Names.fromJson(json['names']),
        keyPosition: json['keyPosition'],
        roles: List<String>.from(json['roles']),
        values: (json['values'] as List)
            .map((i) => DimensionValue.fromJson(i))
            .toList(),
      );
  final String id;
  final String name;
  final Names names;
  final int keyPosition;
  final List<String> roles;
  final List<DimensionValue> values;

  @override
  String toString() {
    return 'ObservationDimension(id: $id, name: $name, names: $names, keyPosition: $keyPosition, roles: $roles, values: $values)';
  }
}
