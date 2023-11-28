// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutteribgeapi/src/feature/home/home_page_vm.dart';

import 'package:flutteribgeapi/src/model/cidade.dart';

class CidadesDetailTile extends ConsumerWidget {
  final int index;
  final Cidade cidade;

  const CidadesDetailTile({
    Key? key,
    required this.index,
    required this.cidade,
  }) : super(key: key);

   @override
   Widget build(BuildContext context, WidgetRef ref) {
    final homepagevariaveis = ref.watch(homePageVmProvider);
       return  InkWell(
        onTap: () {
          ref.read(homePageVmProvider.notifier).setCidadeINdex(index);
        },
         child: Container(
             padding: const EdgeInsets.all(20),
             margin: const EdgeInsets.only(bottom: 10),
             decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color:
            homepagevariaveis.cidadeindex != null && 
            homepagevariaveis.cidadeindex ==  index?  
            Colors.greenAccent: Colors.grey[350]!),
             ),
             child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Text(
                cidade.nome,
                
              ),
            ),
            Text(
              cidade.estado
            
            ),
            Expanded(
              child: Text(
                cidade.codigo.toString(),
                textAlign: TextAlign.end,
              ),
            ),
          ],
             ),
           ),
       );
  }
}
