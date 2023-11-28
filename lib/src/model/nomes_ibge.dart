import 'dart:convert';

import 'package:flutteribgeapi/src/model/resultado_nomes.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class NomesIbge {
  
  final String nome;
  final List<ResultadoNomes> resultado;
  
  NomesIbge({
    required this.nome,
    required this.resultado,
  });

  factory NomesIbge.fromMap(Map<String, dynamic> json) {
     switch(json){
      case{
        'nome': final String nome,
        'res': final  List result
        
      }: return NomesIbge(
        nome: nome,
        resultado: result.map<ResultadoNomes>((e) => ResultadoNomes.fromMap(e)).toList(),
       );
      case _:
        throw ArgumentError('Invalid JSON');  
    }
  }

  factory NomesIbge.fromJson(String source) => NomesIbge.fromMap(json.decode(source) as Map<String, dynamic>);


}
