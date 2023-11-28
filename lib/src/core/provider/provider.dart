
import 'package:flutteribgeapi/src/repository/ibge_repository.dart';
import 'package:flutteribgeapi/src/repository/ibge_repository_impl.dart';
import 'package:flutteribgeapi/src/service/ibge_service.dart';
import 'package:flutteribgeapi/src/service/ibge_service_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../restclient/rest_client.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();

@Riverpod(keepAlive: true)
IbgeService ibgeService(IbgeServiceRef ref)=>
  IbgeServiceImpl (ref.read(ibgeRepositoryProvider) );

@Riverpod(keepAlive: true)
IbgeRepository ibgeRepository(IbgeRepositoryRef ref)=>
  IbgeRepositoryImpl(ref.read(restClientProvider));