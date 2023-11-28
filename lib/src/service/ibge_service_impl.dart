// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutteribgeapi/src/core/either/either.dart';
import 'package:flutteribgeapi/src/core/either/service_exception.dart';
import 'package:flutteribgeapi/src/model/cidade.dart';
import 'package:flutteribgeapi/src/model/nomes_ibge.dart';
import 'package:flutteribgeapi/src/model/ranking_nomes.dart';
import 'package:flutteribgeapi/src/repository/ibge_repository.dart';
import 'package:flutteribgeapi/src/service/ibge_service.dart';

class IbgeServiceImpl implements IbgeService {
  final IbgeRepository _repository;
  IbgeServiceImpl(
     this._repository,
  );
 
  @override
  Future<Either<ServiceException, NomesIbge>> nomesPorcidade(String nome, int codigoCidade) async {
    final result = await _repository.buscaporNome(nome, codigoCidade);
     switch (result) {
      case Sucess(: final value):
          return Sucess(value);
      case Failure( : final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, List<Cidade>>> buscaCidades(String cidade) async {
     final result = await _repository.buscacidadePorNome(cidade);
    switch (result) {
      case Sucess(: final value):
          return Sucess(value);
      case Failure( : final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }

  @override
  Future<Either<ServiceException, RankingNomes>> rankingPorCidade(int codigoCidade) async {
   final result = await _repository.buscaRankingNomes(codigoCidade);
     switch (result) {
      case Sucess(: final value):
          return Sucess(value);
      case Failure( : final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }
  
}
