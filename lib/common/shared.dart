import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

/// source https://www.dicoding.com/academies/199/discussions/136107
/// source https://stackoverflow.com/a/69511058/13238988
class Shared {
  static Future<HttpClient> customHttpClient() async {
    SecurityContext context = SecurityContext(withTrustedRoots: false);

    try {
      List<int> bytes = (await rootBundle.load('certificates/certificates.pem'))
          .buffer
          .asUint8List();

      context.setTrustedCertificatesBytes(bytes);
    } on TlsException catch (e) {
      if (e.osError?.message != null &&
          e.osError!.message.contains('CERT_ALREADY_IN_HASH_TABLE')) {
        log('createHttpClient() - cert already trusted! Skipping.');
      } else {
        log('createHttpClient().setTrustedCertificateBytes EXCEPTION: $e');
        rethrow;
      }
    } catch (e) {
      log('error $e');
      rethrow;
    }

    HttpClient _client = HttpClient(context: context);

    _client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;

    return _client;
  }

  static Future<http.Client> createLEClient() async {
    IOClient client = IOClient(await customHttpClient());
    return client;
  }
}
