part of '../sdmx_model.dart';

class ObservationAttribute {
  const ObservationAttribute({
    required this.id,
    required this.name,
    required this.names,
    required this.roles,
    required this.relationship,
    required this.values,
  });

  factory ObservationAttribute.fromJson(
    Map<String, dynamic> json,
  ) =>
      ObservationAttribute(
        id: json['id'],
        name: json['name'],
        names: Names.fromJson(json['names']),
        roles: List<String>.from(json['roles']),
        relationship: Relationship.fromJson(json['relationship']),
        values: (json['values'] as List)
            .map((i) => AttributeValue.fromJson(i))
            .toList(),
      );

  final String id;
  final String name;
  final Names names;
  final List<String> roles;
  final Relationship relationship;
  final List<AttributeValue> values;

  @override
  String toString() {
    return 'ObservationAttribute(id: $id, name: $name, names: $names, roles: $roles, relationship: $relationship, values: $values)';
  }
}
