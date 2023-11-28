// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutteribgeapi/src/core/ui/messages.dart';
import 'package:flutteribgeapi/src/feature/home/home_page_vm.dart';
import 'package:flutteribgeapi/src/feature/home/widget/cidades_detail_tile.dart';

import 'package:flutteribgeapi/src/model/cidade.dart';

class DetailCidade extends ConsumerStatefulWidget {

final List<Cidade> cidades;

  const DetailCidade({
    Key? key,
    required this.cidades,
  }) : super(key: key);

  @override
  ConsumerState<DetailCidade> createState() => _DetailCidadeState();
}

class _DetailCidadeState extends ConsumerState<DetailCidade> {

  var select;

   @override
   Widget build(BuildContext context) {
    final cidades = widget.cidades;
       return Material(
      color: Colors.black26,
      child: Dialog(
        backgroundColor: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          width: MediaQuery.of(context).size.width * (MediaQuery.of(context).size.width  > 1200 ? .5 : .7),
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Selecione uma cidade',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: cidades.length,
                  itemBuilder: (context, index) {
                  final cidade = cidades[index];
                  return CidadesDetailTile(index: index, cidade: cidade);
                },),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                 children: [
                  ElevatedButton(onPressed: () {
                    if(ref.read(homePageVmProvider).cidadeindex != null){
                      ref.read(homePageVmProvider.notifier).setCidade();
                      Navigator.of(context).pop();
                    }else{
                      Messages.showError('Nenhuma cidade selecionada.', context);
                    }
                    
                  }, child:const Text('Selecionar')),
                  const SizedBox(
                     width: 15,
                  ),
                  ElevatedButton(onPressed: () {
                    ref.read(homePageVmProvider.notifier).popDetail();
                    Navigator.of(context).pop();
                  }, child:const Text('Cancelar'))
                 ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}