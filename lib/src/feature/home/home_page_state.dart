// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutteribgeapi/src/model/cidade.dart';
import 'package:flutteribgeapi/src/model/nomes_ibge.dart';
import 'package:flutteribgeapi/src/model/ranking_nomes.dart';

enum HomePageStateStatus { initial, loaded, showmodal, error }

class HomePageState {
  final HomePageStateStatus status;
  final int codigoCidade;
  final bool pesquisaNome;
  final bool pesquisaRanking;
  final RankingNomes? rankingNomes;
  final Cidade? cidade;
  final int? cidadeindex;
  final List<Cidade>? listacidades;
  final NomesIbge? nomesIbge;
  HomePageState({
    required this.status,
    required this.codigoCidade,
    required this.pesquisaNome,
    required this.pesquisaRanking,
    this.rankingNomes,
    this.cidade,
    this.cidadeindex,
    this.listacidades,
    this.nomesIbge,
  });

  HomePageState.initial()
      : this(
          status: HomePageStateStatus.initial,
          pesquisaNome: true,
          pesquisaRanking: false,
          codigoCidade: 4104808,
        );

  HomePageState copyWith({
    HomePageStateStatus? status,
    int? codigoCidade,
    bool? pesquisaNome,
    bool? pesquisaRanking,
    RankingNomes? rankingNomes,
    Cidade? cidade,
    int? cidadeindex,
    List<Cidade>? listacidades,
    NomesIbge? nomesIbge,
  }) {
    return HomePageState(
      status: status ?? this.status,
      codigoCidade: codigoCidade ?? this.codigoCidade,
      pesquisaNome: pesquisaNome ?? this.pesquisaNome,
      pesquisaRanking: pesquisaRanking ?? this.pesquisaRanking,
      rankingNomes: rankingNomes,
      cidade: cidade,
      cidadeindex: cidadeindex ?? this.cidadeindex,
      listacidades: listacidades ?? this.listacidades,
      nomesIbge: nomesIbge,
    );
  }
}
