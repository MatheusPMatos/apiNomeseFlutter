import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutteribgeapi/src/core/ui/text_constant.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/messages.dart';
import '../../../model/cidade.dart';
import '../home_page_state.dart';
import '../home_page_vm.dart';
import 'detail_cidade.dart';

class NomesForm extends ConsumerStatefulWidget {
  const NomesForm({super.key});

  @override
  ConsumerState<NomesForm> createState() => _NomesFormState();
}

class _NomesFormState extends ConsumerState<NomesForm> {
  final _formKey = GlobalKey<FormState>();
  final _nomeEC = TextEditingController();
  final _cidadeEC = TextEditingController();

  @override
  void dispose() {
    _cidadeEC.dispose();
    _nomeEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homePageMetodos = ref.read(homePageVmProvider.notifier);
    final homepageVariaveis = ref.watch(homePageVmProvider);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(
              height: 150,
              child: Text(
                TextConstant.descricaoPesquisaNome,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              )),
          const Divider(
            color: Colors.grey,
            height: 15,
            thickness: .5,
          ),
          TextFormField(
            controller: _nomeEC,
            validator: Validatorless.multiple([
              Validatorless.required('Digite um nome para pesquisar.'),
              Validatorless.onlyCharacters(
                  'Digite apenas caracteres, sem numeros ou simbolos.'),
            ]),
            decoration: InputDecoration(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.sizeOf(context).width * .4),
                hintText: 'Digite seu nome aqui',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 120,
              ),
              TextFormField(
                controller: _cidadeEC,
                decoration: InputDecoration(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.sizeOf(context).width * .4),
                    hintText: 'Digite o nome da cidade para pesquisar.',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      minimumSize: const Size(120, 54)),
                  onPressed: () {
                    switch (_formKey.currentState?.validate()) {
                      case (false || null):
                        Messages.showError(
                            'Digite um nome para pesquisar.', context);
                        break;
                      case true:
                        if (_cidadeEC.text.isEmpty) {
                          Messages.showError(
                              'Digite uma cidade para pesquisar.', context);
                        } else {
                          homePageMetodos.buscaCidade(_cidadeEC.text);
                        }
                    }
                  },
                  child: const Text(
                    'Buscar',
                    style: TextStyle(fontSize: 18),
                  ))
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  minimumSize:
                      Size(MediaQuery.of(context).size.width * .4, 54)),
              onPressed: () {
                if (_cidadeEC.text.isEmpty) {
                  _cidadeEC.text = 'Cascavel-PR';
                }
                switch (_formKey.currentState?.validate()) {
                  case (false || null):
                    Messages.showError(
                        'Digite um nome para pesquisar.', context);
                    break;
                  case true:
                    _cidadeEC.text =
                        '${homepageVariaveis.cidade!.nome} - ${homepageVariaveis.cidade!.estado}';
                    homePageMetodos.pesquisaNomePorcidade(_nomeEC.text);
                }
              },
              child: const Text(
                'Pesquisar',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ))
        ],
      ),
    );
  }
}
