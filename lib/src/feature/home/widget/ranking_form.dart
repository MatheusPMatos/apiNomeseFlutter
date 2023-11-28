import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/ui/messages.dart';
import '../../../core/ui/text_constant.dart';
import '../home_page_vm.dart';

class RankingForm extends ConsumerStatefulWidget {

  const RankingForm({ super.key });

  @override
  ConsumerState<RankingForm> createState() => _RankingFormState();
}

class _RankingFormState extends ConsumerState<RankingForm> {
  final _formKey = GlobalKey<FormState>();
  final _cidadeEC = TextEditingController();
  @override
  void dispose() {
    _cidadeEC.dispose();
    super.dispose();
  }
   @override
   Widget build(BuildContext context) {
     final homePageMetodos = ref.read(homePageVmProvider.notifier);
     final homepageVariaveis = ref.watch(homePageVmProvider);
       return Column(
        children: [
           const SizedBox(
            height: 150,
            child:  Text(TextConstant.descricaoPesquisaRanking, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)),
            Divider(
            color: Colors.grey,
             height: 15,
             thickness: .5,
             indent: MediaQuery.sizeOf(context).width *.2,
             endIndent: MediaQuery.sizeOf(context).width *.2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                     width: 120,
                  ),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _cidadeEC,
                  decoration: InputDecoration(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width *.4
                ),
                hintText: 'Digite o nome da cidade para pesquisar.',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30))),
                ),
              ),
              const SizedBox(
                 width: 15,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  minimumSize: const Size(120, 54)),
                onPressed: ()  {
                switch (_formKey.currentState?.validate()) {
                                    case (false || null ):
                                      Messages.showError(
                                          'Digite um nome para pesquisar.', context);
                                      break;
                                    case true:
                                    if(_cidadeEC.text.isEmpty){
                                     Messages.showError(
                                          'Digite um nome para pesquisar.', context);
                                    }else{
                                      homePageMetodos.buscaCidade(_cidadeEC.text);
                                    }
                                       
                                  }
              }, child: const Text( 'Buscar', style: TextStyle(fontSize: 18),))
            ],
          ),
          const SizedBox(
             height: 18,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              minimumSize: Size(MediaQuery.of(context).size.width*.4, 54)),
            onPressed: () {
              if (_cidadeEC.text.isEmpty){
                _cidadeEC.text = 'Cascavel-PR';
              }
              switch (_formKey.currentState?.validate()) {
                                    case (false || null):
                                      Messages.showError(
                                          'Faça a busca da cidade antes de pesquisar', context);
                                      break;
                                    case true:
                                     _cidadeEC.text = '${homepageVariaveis.cidade!.nome} - ${homepageVariaveis.cidade!.estado}';
                                      homePageMetodos.pesquisaRankingNomes();
                                      
                                  }
          }, child: const Text('Pesquisar',style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),)),
        ],
       );
  }
}