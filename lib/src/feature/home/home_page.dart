
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutteribgeapi/src/feature/home/home_page_state.dart';
import 'package:flutteribgeapi/src/feature/home/home_page_vm.dart';
import 'package:flutteribgeapi/src/feature/home/widget/detail_cidade.dart';
import 'package:flutteribgeapi/src/feature/home/widget/nomes_form.dart';
import 'package:flutteribgeapi/src/feature/home/widget/ranking_form.dart';
import 'package:flutteribgeapi/src/feature/home/widget/result_list.dart';

import '../../core/ui/messages.dart';
import '../../model/cidade.dart';


class HomePage extends ConsumerStatefulWidget {

  const HomePage({ super.key });

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  var modal =false;
  void showDetail() {
    modal = true;
    showDialog(
      context: context,
      builder: (context) {
        return DetailCidade(
          cidades: ref.read(homePageVmProvider).listacidades!,
        );
      },
    );
  }
  

   @override
   Widget build(BuildContext context) {
   
     final homepageVariaveis = ref.watch(homePageVmProvider);
     final homePageMetodos = ref.read(homePageVmProvider.notifier);
    ref.listen(
      homePageVmProvider,
      (_, state) async {
        switch (state.status) {
          case HomePageStateStatus.initial:
          case HomePageStateStatus.loaded:
            break;
          case HomePageStateStatus.showmodal:
          showDetail();
            break;
          case HomePageStateStatus.error:
           Messages.showError('Nenhuma cidade encontrada', context);
           break;
        }
      },
    );

       return Scaffold(
           body: Padding(
             padding: const EdgeInsets.only(left:15.0, right: 15),
             child: SingleChildScrollView(
               child:  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                        
                       Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: 120,
                        decoration:  BoxDecoration(
                          borderRadius:  const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                          color: Colors.blueGrey[100],
                          boxShadow:[ const BoxShadow(color: Colors.black, blurRadius: BorderSide.strokeAlignOutside)] ,
                        ),
                        child:const Center(child:  Text('Informações sobre nomes pelo Brasil!', style: TextStyle(color: Colors.blueGrey, fontSize: 32, fontWeight: FontWeight.w600),))),
                       const SizedBox(
                          height: 30,
                       ),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          side:const BorderSide(color: Colors.blue, width: 1),
                          backgroundColor: homepageVariaveis.pesquisaNome? Colors.blue : Colors.white70),
                        onPressed: () {
                        homePageMetodos.setTipoPesquisa(true);
                       }, child: Text("Pesquise seu Nome", style: TextStyle(color: homepageVariaveis.pesquisaNome? Colors.white : Colors.black, fontSize: 24))),
                       const SizedBox(
                          width: 15,
                       ),
                       ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          side:const BorderSide(color: Colors.blue, width: 1),
                          backgroundColor: homepageVariaveis.pesquisaRanking? Colors.blue : Colors.white70),
                        onPressed: () {
                        homePageMetodos.setTipoPesquisa(false);
                       }, child:  Text("Ranking dos Nomes", style: TextStyle(color: homepageVariaveis.pesquisaRanking? Colors.white : Colors.black, fontSize: 24) ,))
                        ],
                       ), 
                   const SizedBox(
                      height: 25,
                   ), 
                   Visibility(
                    visible: homepageVariaveis.pesquisaNome,
                    child:const NomesForm(),
                   ),
                    Visibility(
                      visible: homepageVariaveis.pesquisaRanking,
                      child: const RankingForm(),
                      ),
                  const SizedBox(
                     height: 15,
                  ),
                  Visibility(
                 
                    visible: !(homepageVariaveis.cidade == null),
                    child: SizedBox(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Column(
                          children: [
                            Text(homepageVariaveis.cidade != null ? 'Cidade: ${homepageVariaveis.cidade!.nome}' : "tests",
                          style: const  TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                          
                        ),
                        const SizedBox(
                             height: 10,
                          ),
                        Text(homepageVariaveis.cidade != null? 'Estado: ${homepageVariaveis.cidade!.estado}':"tesata",  
                        style:const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                          ],
                        ),
                      ),
                    ),
                    ),
                    const SizedBox(
                      height: 25,
                   ),
                   ResultList(
                    cidade: homepageVariaveis.cidade,
                    listNomes: homepageVariaveis.pesquisaNome, 
                    nomesList: homepageVariaveis.nomesIbge, 
                    rankingList: homepageVariaveis.rankingNomes, ),
                 ],
               ),
             ),
           ),
       );
  }
}