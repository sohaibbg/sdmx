import 'dart:convert';

import 'package:sdmx/sdmx.dart';

/// implement this class and pass it to an
/// [SDMXServer] constructor. This can enable
/// logging, caching or insert support for
/// formats like CSV which aren't yet supported
abstract class SDMXDecoder {
  /// convert a network response to an [SDMXModel] object
  SDMXModel<T> decode<T extends Object>(
    String response,
  );

  /// the extra header to insert to retrieve
  /// a response in the format supported by
  /// this decoder, e.g. for JSON
  /// ```dart
  /// {
  ///   'Accept': 'application/vnd.sdmx.data+json',
  /// }
  /// ```
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
