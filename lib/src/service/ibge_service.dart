import 'package:flutteribgeapi/src/core/either/either.dart';
import 'package:flutteribgeapi/src/core/either/service_exception.dart';
import 'package:flutteribgeapi/src/model/cidade.dart';
import 'package:flutteribgeapi/src/model/nomes_ibge.dart';
import 'package:flutteribgeapi/src/model/ranking_nomes.dart';

abstract interface class IbgeService {
  Future<Either<ServiceException, NomesIbge>> nomesPorcidade(String nome, int codigoCidade);
  Future<Either<ServiceException, List<Cidade>>> buscaCidades(String cidade);
  Future<Either<ServiceException, RankingNomes>>rankingPorCidade(int codigoCidade);
}