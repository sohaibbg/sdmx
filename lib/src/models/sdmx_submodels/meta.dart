part of '../sdmx_model.dart';

class Meta {
  const Meta({
    required this.schema,
    required this.id,
    required this.prepared,
    required this.test,
    required this.contentLanguages,
    required this.sender,
  });

  factory Meta.fromJson(
    Map<String, dynamic> json,
  ) =>
      Meta(
        schema: json['schema'],
        id: json['id'],
        prepared: DateTime.parse(json['prepared']),
        test: json['test'],
        contentLanguages: List<String>.from(json['contentLanguages']),
        sender: Sender.fromJson(json['sender']),
      );

  final String schema;
  final String id;
  final DateTime prepared;
  final bool test;
  final List<String> contentLanguages;
  final Sender sender;

  @override
  String toString() {
    return 'Meta(schema: $schema, id: $id, prepared: $prepared, test: $test, contentLanguages: $contentLanguages, sender: $sender)';
  }
}
