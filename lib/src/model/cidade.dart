import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Cidade {
  final int codigo;
  final String nome;
  final String estado;
  Cidade({
    required this.codigo,
    required this.nome,
    required this.estado,
  });


  factory Cidade.fromMap(Map<String, dynamic> map) {
    return Cidade(
      codigo: map['id'] as int,
      nome: map['nome'] as String,
      estado: map['microrregiao']['mesorregiao']['UF']['nome'] as String,
    );
  }

  factory Cidade.fromJson(String source) => Cidade.fromMap(json.decode(source) as Map<String, dynamic>);
}
