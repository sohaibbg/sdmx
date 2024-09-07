part of '../sdmx_model.dart';

class Annotation {
  const Annotation({
    required this.type,
    this.title,
    required this.text,
    this.texts,
  });

  factory Annotation.fromJson(
    Map<String, dynamic> json,
  ) =>
      Annotation(
        type: json['type'],
        title: json['title'],
        text: json['text'],
        texts: json['texts'] != null ? Names.fromJson(json['texts']) : null,
      );

  final String type;
  final String? title;
  final String? text;
  final Names? texts;

  @override
  String toString() {
    return 'Annotation(type: $type, title: $title, text: $text, texts: $texts)';
  }
}
