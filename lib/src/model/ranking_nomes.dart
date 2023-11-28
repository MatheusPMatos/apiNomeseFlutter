// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutteribgeapi/src/model/resultado_ranking.dart';

class RankingNomes {
 final String localidade;
  final List<ResultadoRanking> resultados;
  RankingNomes({
    required this.localidade,
    required this.resultados,
  });
  
  factory RankingNomes.fromMap(Map<String, dynamic> json) {
    switch (json) {
      case {
          'localidade': final String localidade,
          'res': final List result,
        }:
        return RankingNomes(
          localidade: localidade, 
          resultados: result.map<ResultadoRanking>((e)=> ResultadoRanking.fromMap(e)).toList());
      case _:
        throw ArgumentError('Invalid Json');
    }
    
  }

  factory RankingNomes.fromJson(String source) =>
      RankingNomes.fromMap(json.decode(source) as Map<String, dynamic>);
}
