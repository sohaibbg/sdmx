part of '../sdmx_model.dart';

class AttributeValue {
  const AttributeValue({
    required this.id,
    required this.order,
    required this.name,
    required this.names,
  });

  factory AttributeValue.fromJson(
    Map<String, dynamic> json,
  ) =>
      AttributeValue(
        id: json['id'],
        order: json['order'],
        name: json['name'],
        names: Names.fromJson(json['names']),
      );

  final String id;
  final int? order;
  final String name;
  final Names names;

  @override
  String toString() {
    return 'AttributeValue(id: $id, order: $order, name: $name, names: $names)';
  }
}
