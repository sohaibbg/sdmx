import 'package:sdmx/sdmx.dart';
import 'package:sdmx/src/services/map_equals.dart';

/// designed to be easily understandable and filterable.
/// The [Names] object contains strings in locales
/// defined in [SDMXServer].
class SdmxRecordEntry<T extends Object> {
  final List<int> key;
  final T value;
  final Map<String, String> propertiesAsIds;
  final Map<Names, Names> propertiesAsNames;

  const SdmxRecordEntry({
    required this.key,
    required this.value,
    required this.propertiesAsIds,
    required this.propertiesAsNames,
  });

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
