import 'package:dio/browser.dart';
import 'package:dio/dio.dart';

final class RestClient extends DioForBrowser {
  RestClient(): super(BaseOptions(
    baseUrl:  'https://servicodados.ibge.gov.br/api/',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),

  ));
}