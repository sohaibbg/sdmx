part of '../sdmx_model.dart';

/// Data divided by language
class Names<T> {
  const Names({required this.data});

  factory Names.fromJson(
    Map<String, T> json,
  ) =>
      Names(data: json);

  final Map<String, T> data;

  T forLanguage(String language) => data[language]!;

  @override
  String toString() => data.toString();

  @override
  bool operator ==(covariant Names<T> other) {
    if (identical(this, other)) return true;

    return mapsEqual(other.data, data);
  }

  @override
  int get hashCode => data.hashCode;
}
