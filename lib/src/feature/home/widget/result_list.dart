// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutteribgeapi/src/model/nomes_ibge.dart';
import 'package:flutteribgeapi/src/model/ranking_nomes.dart';

import '../../../model/cidade.dart';

class ResultList extends StatelessWidget {
  final bool listNomes;
  final RankingNomes? rankingList;
  final NomesIbge? nomesList;
  final Cidade? cidade;

  const ResultList({
    Key? key,
    required this.listNomes,
    this.rankingList,
    this.nomesList,
    required this.cidade,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (rankingList != null && !listNomes) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final result = rankingList!.resultados[index];
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: .5),
                          borderRadius: BorderRadius.circular(20)),
                      width: MediaQuery.sizeOf(context).width * .4,
                      height: 65,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                      'Nome: ${result.nome}',
                                      style: const TextStyle(fontSize: 22),
                                      textAlign: TextAlign.center,
                                                          ),
                            ),
                             Text(
                              '${result.ranking}º',
                              style: const TextStyle(fontSize: 22),
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                               width: 10,
                            ),
                  
                              ],
                            ),
                            
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Nascidos: ${result.frequencia}',
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                           
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.black87,
                  endIndent: MediaQuery.of(context).size.width * .4,
                  indent: MediaQuery.of(context).size.width * .4,
                  thickness: .5,
                );
              },
              itemCount: rankingList!.resultados.length),
        ],
      );
    } else if (nomesList != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final result = nomesList!.resultado[index];
                final periodo = result.periodo.replaceAll('[', '').split(',');
                return Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: .5),
                      borderRadius: BorderRadius.circular(20)),
                  width: MediaQuery.sizeOf(context).width * .4,
                  height: 65,
                  child: Center(
                      child: Column(
                    children: [
                      Text(
                        periodo.length > 1
                            ? 'De ${periodo[0]} a ${periodo[1]}'
                            : 'Em ${periodo[0]}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Nascidos: ${result.frequencia}.',
                        style: const TextStyle(fontSize: 24),
                      )
                    ],
                  )),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.black87,
                  endIndent: MediaQuery.of(context).size.width * .4,
                  indent: MediaQuery.of(context).size.width * .4,
                  thickness: .5,
                );
              },
              itemCount: nomesList!.resultado.length),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
