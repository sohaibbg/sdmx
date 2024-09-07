import 'package:sdmx/sdmx.dart';
import 'package:sdmx/src/services/map_equals.dart';

/// designed to be easily understandable and filterable.
/// The [Names] object contains strings in locales
/// defined in [SDMXServer].
class SdmxRecordEntry<T extends Object> {
  /// each element is an index for the options in model.extractDimensionOptionsAsIds
  final List<int> key;

  /// usually a number value
  final T value;

  /// displays properties in their ID form, e.g.
  /// ```dart
  /// {"REF_AREA": "UAE", "TIME_PERIOD": "2023"}
  /// ```
  final Map<String, String> propertiesAsIds;

  /// displays properties in their translations, e.g.
  /// ```dart
  /// {{
  ///   "en": "REF_AREA", "ar": "...some arabic translation..."
  /// }: {
  ///   "en": "UAE", "ar": "...some arabic translation..."
  /// }, {
  ///   "en": "TIME_PERIOD", "ar": "...some arabic translation..."
  /// }: {
  ///   "en": "2023", "ar": "...some arabic translation..."
  /// }}
  /// ```
  final Map<Names, Names> propertiesAsNames;

  const SdmxRecordEntry({
    required this.key,
    required this.value,
    required this.propertiesAsIds,
    required this.propertiesAsNames,
  });

  /// pass a filter like
  /// ```dart
  /// {
  ///   'TIME_PERIOD': ['2018', '2019'],
  /// }
  /// ```
  /// to only get records from 2018 and 2019
  bool anyPropertyInIdFormMatches(
    Map<String, List<String>> filter,
  ) =>
      filter.entries.any(
        (filterEntry) {
          final propertyValue = propertiesAsIds[filterEntry.key];
          return filterEntry.value.contains(
            propertyValue,
          );
        },
      );

  @override
  String toString() =>
      'SdmxRecordEntry(properties: $propertiesAsIds, value: $value)';

  @override
  bool operator ==(covariant SdmxRecordEntry<T> other) {
    if (identical(this, other)) return true;
    if (key.length != other.key.length) return false;
    for (int i = 0; i < key.length; i++) {
      if (key[i] != other.key[i]) return false;
    }
    if (value != other.value) return false;
    if (!mapsEqual(propertiesAsIds, other.propertiesAsIds)) return false;
    if (!mapsEqual(propertiesAsNames, other.propertiesAsNames)) return false;
    return true;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      value.hashCode ^
      propertiesAsIds.hashCode ^
      propertiesAsNames.hashCode;
}
