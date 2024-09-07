import 'package:sdmx/src/entities/sdmx_record_entry.dart';
import 'package:sdmx/src/services/map_equals.dart';

part 'sdmx_submodels/annotation.dart';
part 'sdmx_submodels/attribute_value.dart';
part 'sdmx_submodels/attributes.dart';
part 'sdmx_submodels/data.dart';
part 'sdmx_submodels/dataset.dart';
part 'sdmx_submodels/dimension_value.dart';
part 'sdmx_submodels/dimensions.dart';
part 'sdmx_submodels/link.dart';
part 'sdmx_submodels/meta.dart';
part 'sdmx_submodels/names.dart';
part 'sdmx_submodels/observation_attribute.dart';
part 'sdmx_submodels/observation_dimension.dart';
part 'sdmx_submodels/relationship.dart';
part 'sdmx_submodels/sender.dart';
part 'sdmx_submodels/structure.dart';

/// designed to mimic the JSON structure of an SDMX response
class SDMXModel<T extends Object> {
  const SDMXModel({
    required this.meta,
    required this.data,
    required this.errors,
    required this.rawJson,
  });

  /// mimicked from the SDMX standard
  final Meta meta;

  /// mimicked from the SDMX standard
  final Data data;

  /// mimicked from the SDMX standard
  final List<dynamic> errors;

  /// Not part of the standard. contains the
  /// raw json received by the constructor
  /// so you can inspect it later.
  final Map<String, dynamic> rawJson;

  /// name extracted from data structure in the variety of locales
  String get name => data.structures
      .map(
        (structure) => structure.names.data.values.join(', '),
      )
      .join('\n');

  /// lists all possible dimension options
  /// for this model in their ID forms, e.g.
  /// ```dart
  /// {"MEASURE":["POPGWTH","POP"],"UNIT_MEASURE":["RATE","PS"],"REF_AREA":["AE"],"FREQ":["A"],"GENDER":["F","_T","M"],"POP_IND":["_Z"],"SOURCE_DETAIL":["FCSC"],"TIME_PERIOD":["2017","2018","2019","2020"]}
  /// ```
  Map<String, List<String>> extractDimensionOptionsAsIds() {
    final entries = data.structures
        .map(
          (structure) => structure.dimensions.observation,
        )
        .first
        .map(
          (observationDimension) => MapEntry(
            observationDimension.id,
            observationDimension.values
                .map(
                  (dimensionValue) => dimensionValue.id,
                )
                .toList(),
          ),
        );
    return Map.fromEntries(entries);
  }

  /// lists all possible dimension options
  /// for this model in their translated forms, e.g.
  /// ```dart
  /// {{en: Measure, ar: القياس}: [{en: Population Growth Rate, ar: معدل النمو السكاني}, {en: Population Estimate, ar: تقديرات السكان}], {en: Unit of measure, ar: وحدة القياس}: [{en: Rate, ar: معدل}, {en: Persons, ar: الأفراد}], {en: Reference area, ar: النطاق الجغرافي}: [{en: UAE, ar: الإمارات العربية المتحدة}], {en: Frequency, ar: الدورية}: [{en: Annual, ar: سنوي}], {en: Gender, ar: النوع}: [{en: Female, ar: أنثى}, {en: Total, ar: الإجمالي}, {en: Male, ar: ذكر}], {en: Population Indicators, ar: المؤشرات السكانية}: [{en: Not Applicable, ar: لا ينطبق}], {en: Source, ar: المصدر}: [{en: Federal Competitiveness and Statistics Centre, ar: المركز الاتحادي للتنافسية والإحصاء}], {en: Time period, ar: الفترة الزمنية}: [{en: 2017}, {en: 2018}, {en: 2019}, {en: 2020}]}
  /// ```
  Map<Names, List<Names>> extractDimensionOptionsAsNames() {
    final entries = data.structures
        .map(
          (structure) => structure.dimensions.observation,
        )
        .first
        .map(
          (observationDimension) => MapEntry(
            observationDimension.names,
            observationDimension.values
                .map(
                  (dimensionValue) => dimensionValue.names,
                )
                .toList(),
          ),
        );
    return Map.fromEntries(entries);
  }

  /// converts model into a list of [SdmxRecordEntry] objects.
  /// These objects are easier to filter and translate.
  List<SdmxRecordEntry<T>> toEntries() {
    // in this method, dimensions are
    // referred to as properties for the purpose
    // of clarity
    final result = <SdmxRecordEntry<T>>[];
    final allPropertyOptionsAsIds = extractDimensionOptionsAsIds();
    final allPropertyOptionsAsNames = extractDimensionOptionsAsNames();
    final dataPoints = data.dataSets.first.observations.map(
      (key, value) => MapEntry(
        key.split(':').map(int.parse).toList(),
        value.first,
      ),
    );
    final propertyKeysAsIds = allPropertyOptionsAsIds.keys.toList();
    final propertiesValuesAsIds = allPropertyOptionsAsIds.values.toList();
    final propertyKeysAsNames = allPropertyOptionsAsNames.keys.toList();
    final propertiesValuesAsNames = allPropertyOptionsAsNames.values.toList();
    for (final dataPoint in dataPoints.entries) {
      final dpPropertiesKey = dataPoint.key;
      final propertiesAsIds = <String, String>{};
      final propertiesAsNames = <Names, Names>{};
      for (int keyIndex = 0; keyIndex < dpPropertiesKey.length; keyIndex++) {
        final dpPropertyKeyId = propertyKeysAsIds[keyIndex];
        final dpPropertyValueIndex = dpPropertiesKey[keyIndex];
        final dpPropertyValueId =
            propertiesValuesAsIds[keyIndex][dpPropertyValueIndex];
        propertiesAsIds[dpPropertyKeyId] = dpPropertyValueId;
        final dpPropertyKeyNames = propertyKeysAsNames[keyIndex];
        final dpPropertyValueNames =
            propertiesValuesAsNames[keyIndex][dpPropertyValueIndex];
        propertiesAsNames[dpPropertyKeyNames] = dpPropertyValueNames;
      }
      final record = SdmxRecordEntry<T>(
        key: dpPropertiesKey,
        value: dataPoint.value,
        propertiesAsIds: propertiesAsIds,
        propertiesAsNames: propertiesAsNames,
      );
      result.add(record);
    }
    return result;
  }

  @override
  String toString() => 'SDMXModel($name)';
}
