import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class ResultadoNomes {
  final String periodo;
  final int frequencia;
  ResultadoNomes({
    required this.periodo,
    required this.frequencia,
  });

  factory ResultadoNomes.fromMap(Map<String, dynamic> json) {
    switch (json) {
      case {
        'periodo': final String periodo,
        'frequencia': final int frequencia,
      }:return ResultadoNomes(
      periodo: periodo, 
      frequencia: frequencia);
      case _:
        throw ArgumentError('Invalid JSon');
        
      
    }
  }
  
  factory ResultadoNomes.fromJson(String source) => ResultadoNomes.fromMap(json.decode(source) as Map<String, dynamic>);
}
