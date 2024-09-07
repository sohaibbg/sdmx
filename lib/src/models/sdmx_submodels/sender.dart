part of '../sdmx_model.dart';

class Sender {
  const Sender({
    required this.id,
    required this.name,
    required this.names,
  });

  factory Sender.fromJson(
    Map<String, dynamic> json,
  ) =>
      Sender(
        id: json['id'],
        name: json['name'],
        names: Names.fromJson(json['names']),
      );

  final String id;
  final String name;
  final Names names;

  @override
  String toString() => '_Sender(id: $id, name: $name, names: $names)';
}
