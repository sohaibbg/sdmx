import 'dart:convert';

import 'package:sdmx/sdmx.dart';
import 'package:test/test.dart';

import 'sample_json.dart';

void main() {
  final model = SDMXJsonDecoder().decode(
    jsonEncode(sampleJson),
  );
  group(
    'unit test for SDMXModel methods',
    () {
      test(
        'extractDimensionOptionsAsIds',
        () {
          expect(
            model.extractDimensionOptionsAsIds().toString(),
            {
              "REF_AREA": [
                "AE-DU",
                "AE-AZ",
                "OTH",
                "AE-FJ",
                "AE-SH",
                "AE-RK",
                "AE"
              ],
              "FREQ": ["A"],
              "UNIT_MEASURE": ["NUMBER"],
              "SOURCE_DETAIL": ["GCAA"],
              "MEASURE": ["AIR_MOV"],
              "MOVEMENT_TYPE": ["ARI", "DEP", "_T"],
              "TIME_PERIOD": [
                "2016",
                "2017",
                "2018",
                "2019",
                "2020",
                "2021",
                "2022",
                "2023"
              ]
            }.toString(),
          );
        },
      );
      test(
        'extractDimensionOptionsAsNames',
        () {
          expect(
              model.extractDimensionOptionsAsNames().toString(),
              {
                {'en': 'Reference area', 'ar': 'منطقة مرجعية'}: [
                  {'en': 'Dubai', 'ar': 'دبي'},
                  {'en': 'Abu Dhabi', 'ar': 'أبوظبي'},
                  {'en': 'Other Local Airports', 'ar': 'مطارات محلية أخرى'},
                  {'en': 'Fujairah', 'ar': 'الفجيرة'},
                  {'en': 'Sharjah', 'ar': 'الشارقة'},
                  {'en': 'Ras Al Khaimah', 'ar': 'رأس الخيمة'},
                  {'en': 'UAE', 'ar': 'الإمارات العربية المتحدة'}
                ],
                {'en': 'Frequency of observation', 'ar': 'تواتر الملاحظة'}: [
                  {'en': 'Annual', 'ar': 'سنوي'}
                ],
                {'en': 'Unit of measure', 'ar': 'وحدة القياس'}: [
                  {'en': 'Number', 'ar': 'عدد'}
                ],
                {'en': 'Source', 'ar': 'المصدر'}: [
                  {
                    'en': 'General Civil Aviation Authority',
                    'ar': 'الهيئة العامة للطيران المدني'
                  }
                ],
                {'en': 'Measure', 'ar': 'القياس'}: [
                  {'en': 'Aircraft Movement', 'ar': 'حركة الطائرات'}
                ],
                {'en': 'Type of Movement', 'ar': 'نوع االحركة'}: [
                  {'en': 'Arrivals', 'ar': 'القادمون'},
                  {'en': 'Departures', 'ar': 'المغادرون'},
                  {'en': 'Total', 'ar': 'المجموع'}
                ],
                {'en': 'Time period', 'ar': 'الفترة الزمنية'}: [
                  {'en': '2016'},
                  {'en': '2017'},
                  {'en': '2018'},
                  {'en': '2019'},
                  {'en': '2020'},
                  {'en': '2021'},
                  {'en': '2022'},
                  {'en': '2023'}
                ]
              }.toString());
        },
      );
      test(
        'name',
        () {
          expect(
            model.name,
            'Aircrafts Movement by Emirate, حركـــــــة الطائرات حسب الإمارة',
          );
        },
      );
    },
  );
}
