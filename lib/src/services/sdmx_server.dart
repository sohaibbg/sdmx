import 'package:http/http.dart' as http;
import 'package:sdmx/sdmx.dart';

/// implement your own [decoder] to add support for
/// non-JSON formats like CSV, or to add a cache or
/// log layer
class SDMXServer {
  final String host;

  final http.Client client = http.Client();

  /// used to decode network responses into [SDMXModel] objects
  final SDMXDecoder decoder;

  /// must be added to get records in a variety of locales
  /// ```dart
  /// ['en', 'ar']
  /// ```
  final List<String> locales;

  SDMXServer(
    this.host, {
    this.decoder = const SDMXJsonDecoder(),
    this.locales = const ['en'],
  });

  /// fetches [path] in [locales]
  /// from [host] and maps it to [SDMXModel]
  /// using [decoder]
  Future<SDMXModel<T>> fetchRecord<T extends Object>(
    String path,
  ) async {
    final response = await client.get(
      Uri.parse('$host/$path'),
      headers: {
        ...decoder.headerAddition,
        'Accept-Language': locales.join(','),
      },
    );
    final didApiCallSucceed = response.statusCode.toString().startsWith('2');
    if (!didApiCallSucceed) throw response;
    final model = decoder.decode<T>(response.body);
    return model;
  }
}
