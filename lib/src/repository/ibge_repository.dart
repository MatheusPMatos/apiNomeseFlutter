

import 'package:flutteribgeapi/src/core/either/either.dart';
import 'package:flutteribgeapi/src/core/either/repository_exception.dart';
import 'package:flutteribgeapi/src/model/cidade.dart';
import 'package:flutteribgeapi/src/model/nomes_ibge.dart';
import 'package:flutteribgeapi/src/model/ranking_nomes.dart';

abstract interface class IbgeRepository {
  Future<Either<RepositoryException, NomesIbge>> buscaporNome(String nome, int codigoCidade);
  Future<Either<RepositoryException, List<Cidade>>>buscacidadePorNome(String cidade);
  Future<Either<RepositoryException,RankingNomes>>buscaRankingNomes(int codigoCidade);

}