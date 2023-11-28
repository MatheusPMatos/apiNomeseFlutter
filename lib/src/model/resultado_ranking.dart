import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class ResultadoRanking {
 final String nome;
  final int frequencia;
  final int ranking;
  
  ResultadoRanking({
    required this.nome,
    required this.frequencia,
    required this.ranking,
  });

  factory ResultadoRanking.fromMap(Map<String, dynamic> json) {
    switch (json) {
      case {
        'nome': final String nome,
        'frequencia': final int frequencia,
        'ranking': final int ranking,
      }:return ResultadoRanking(
        nome: nome, 
        frequencia: frequencia, 
        ranking: ranking);
      case _:
        throw ArgumentError('Invalid Json');
    }
  }

  factory ResultadoRanking.fromJson(String source) => ResultadoRanking.fromMap(json.decode(source) as Map<String, dynamic>);
}
