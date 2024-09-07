import 'package:sdmx/sdmx.dart';

void main() async {
  final server = SDMXServer(
    'https://releaseeuaestat.fcsc.gov.ae/rest/data',
    locales: ['en', 'ar'],
  );
  final model = await server.fetchRecord(
    'FCSA,DF_POP,2.6.0/...A...?startPeriod=2017&dimensionAtObservation=AllDimensions',
  );
  final entries = model.toEntries();
  print(model.extractDimensionOptionsAsNames());
  print(entries.length);
  print(entries);
  print(
    entries.where(
      (entry) {
        final tp = int.parse(entry.propertiesAsIds['TIME_PERIOD']!);
        return tp < 2023;
      },
    ).toList(),
  );
  print(
    entries.where(
      (entry) {
        final tp = int.parse(entry.propertiesAsIds['TIME_PERIOD']!);
        return tp >= 2023;
      },
    ).toList(),
  );
  print(
    entries
        .firstWhere(
          (entry) => entry.anyPropertyInIdFormMatches({
            'TIME_PERIOD': ['2018'],
          }),
        )
        .propertiesAsNames
        .keys
        .first
        .forLanguage('ar'),
  );
}
