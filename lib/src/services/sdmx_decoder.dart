import 'dart:convert';

import 'package:sdmx/sdmx.dart';

abstract class SDMXDecoder {
  SDMXModel<T> decode<T extends Object>(
    String response,
  );

  Map<String, String> get headerAddition;
}

class SDMXJsonDecoder implements SDMXDecoder {
  const SDMXJsonDecoder();

  @override
  Map<String, String> get headerAddition => {
        'Accept': 'application/vnd.sdmx.data+json',
      };

  @override
  SDMXModel<T> decode<T extends Object>(
    String response,
  ) {
    final json = jsonDecode(response);
    return SDMXModel<T>(
      meta: Meta.fromJson(json['meta']),
      data: Data.fromJson(json['data']),
      errors: List<dynamic>.from(json['errors']),
      rawJson: json,
    );
  }
}
