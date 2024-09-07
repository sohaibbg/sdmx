part of '../sdmx_model.dart';

class Link {
  const Link({
    required this.urn,
    required this.rel,
  });

  factory Link.fromJson(
    Map<String, dynamic> json,
  ) =>
      Link(
        urn: json['urn'],
        rel: json['rel'],
      );

  final String urn;
  final String rel;

  @override
  String toString() => '_Link(urn: $urn, rel: $rel)';
}
