// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'dart:convert';
import 'dart:developer';
import 'dart:html' as html;


import 'package:dio/dio.dart';
import 'package:flutteribgeapi/src/core/either/either.dart';
import 'package:flutteribgeapi/src/core/either/repository_exception.dart';
import 'package:flutteribgeapi/src/core/restclient/rest_client.dart';
import 'package:flutteribgeapi/src/model/cidade.dart';
import 'package:flutteribgeapi/src/model/nomes_ibge.dart';
import 'package:flutteribgeapi/src/model/ranking_nomes.dart';
import 'package:flutteribgeapi/src/repository/ibge_repository.dart';

class IbgeRepositoryImpl implements IbgeRepository {
final RestClient _restClient;
  IbgeRepositoryImpl(
     this._restClient,
  );

  @override
  Future<Either<RepositoryException, NomesIbge>> buscaporNome(String nome, int codigoCidade) async {
          try {
        final  Response(:List data)= await _restClient.get('v2/censos/nomes/$nome', queryParameters: {'localidade': codigoCidade});
          if (data.isEmpty) {
          throw DioException(requestOptions: RequestOptions());
        }
        return Sucess(NomesIbge.fromMap(data.first));
      } on DioException catch (e) {
        log('DIO Exception', error: e);
        return Failure(RepositoryException(message: "Nome não encontrado."));
      }on ArgumentError catch(e){
        log('Erro ao converter json', error: e);
        return Failure(RepositoryException(message: "Erro no Json traduzido"));
      }
          
  }

  @override
  Future<Either<RepositoryException, List<Cidade>>> buscacidadePorNome(String cidade) async {
   try {
     final  result = await html.HttpRequest.getString('assets/cidades.json');
     final json = jsonDecode(result);
    final List<Cidade> listCidades = json.map<Cidade>((e) => Cidade.fromMap(e)).toList();
    List<Cidade> listafinal = [];

    for (var element in listCidades) {
      if(element.nome.toUpperCase().contains(cidade.toUpperCase()))
      {listafinal.add(element);
    }
    }
    if (listafinal.isEmpty) {
      throw ArgumentError();
    }
    return Sucess(listafinal);
  } on ArgumentError catch(e){
  log('Erro ao converter json', error: e);
  return Failure(RepositoryException(message: "Digite Corretamente o nome da Cidade."));
}
  }

  @override
  Future<Either<RepositoryException,RankingNomes>> buscaRankingNomes(int codigoCidade) async {
      try {
  final Response(:List data) = await _restClient.get('v2/censos/nomes/ranking?localidade=$codigoCidade');
  
  return Sucess(RankingNomes.fromMap(data.first));
} on DioException catch (e) {
  log('DIO Exception', error: e);
  return Failure(RepositoryException(message: "Dados invalidos"));
}on ArgumentError catch(e){
  log('Erro ao converter json', error: e);
  return Failure(RepositoryException(message: "Erro no Json traduzido"));
}
  }
  

  
}
