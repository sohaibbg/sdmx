SDMX stands for Statistical Data and Metadata Exchange. As a format for sharing statistical data, it is used by governments, NGOs and other institutions. This package makes working with SDMX servers and records easier.

## Features

### Fetch from a server

```dart
final server = SDMXServer(
    'https://releaseeuaestat.fcsc.gov.ae/rest/data',
    locales: ['en', 'ar'],
);
final model = await server.fetchRecord(
    'FCSA,DF_POP,2.6.0/...A...?startPeriod=2017&dimensionAtObservation=AllDimensions',
);
```

Fetch records from an SDMX server. The package abstracts away the headers needed to be passed and parses the JSON into a Dart readable object of type `SDMXModel`.

### Access model dimensions neatly

```dart
model.extractDimensionOptionsAsIds() == {"MEASURE":["POPGWTH","POP"],"UNIT_MEASURE":["RATE","PS"],"REF_AREA":["AE"],"FREQ":["A"],"GENDER":["F","_T","M"],"POP_IND":["_Z"],"SOURCE_DETAIL":["FCSC"],"TIME_PERIOD":["2017","2018","2019","2020"]};

model.extractDimensionOptionsAsNames() == {{en: Measure, ar: القياس}: [{en: Population Growth Rate, ar: معدل النمو السكاني}, {en: Population Estimate, ar: تقديرات السكان}], {en: Unit of measure, ar: وحدة القياس}: [{en: Rate, ar: معدل}, {en: Persons, ar: الأفراد}], {en: Reference area, ar: النطاق الجغرافي}: [{en: UAE, ar: الإمارات العربية المتحدة}], {en: Frequency, ar: الدورية}: [{en: Annual, ar: سنوي}], {en: Gender, ar: النوع}: [{en: Female, ar: أنثى}, {en: Total, ar: الإجمالي}, {en: Male, ar: ذكر}], {en: Population Indicators, ar: المؤشرات السكانية}: [{en: Not Applicable, ar: لا ينطبق}], {en: Source, ar: المصدر}: [{en: Federal Competitiveness and Statistics Centre, ar: المركز الاتحادي للتنافسية والإحصاء}], {en: Time period, ar: الفترة الزمنية}: [{en: 2017}, {en: 2018}, {en: 2019}, {en: 2020}]};
```

Use convenience methods to view all possible dimensions in the model records in a human-readable format.

### Filter through model records

```dart
model.toEntries().where(
    (entry) => entry.anyPropertyInIdFormMatches({
    'TIME_PERIOD': ['2018', '2019', '2020', '2021'],
    }),
);
model.toEntries().where(
      (entry) {
        final tp = int.parse(
            entry.propertiesAsIds['TIME_PERIOD']!
        );
        return tp >= 2018 && tp < 2022>;
      },
    );
```

The `SDMXRecordEntry` class is a utility model designed to make filtering records and accessing translations easier. After converting a model to a list of its record entries, you can filter them in a much more readable manner.

### Add support for CSV decoding, cache or logging layers etc.

```dart
abstract class SDMXDecoder {
  SDMXModel<T> decode<T extends Object>(
    String response,
  );

  Map<String, String> get headerAddition;
}
```

Implement the above class to insert a cache or logging layer, or to implement decoders which support beyond the JSON format, such as CSV. The decoder can be inserted in the `SDMXServer` constructor as an optional parameter. The default decoder is `SDMXJsonDecoder`.

## Additional information

Contributions are welcome!

Here is a curated list of how you can help:

- Report bugs and scenarios that are difficult to implement
- Report parts of the documentation that are unclear
- Fix typos/grammar mistakes
- Update the documentation or add examples
- Implement new features by making a pull-request
