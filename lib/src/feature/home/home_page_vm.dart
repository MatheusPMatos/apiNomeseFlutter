import 'package:asyncstate/asyncstate.dart';
import 'package:flutteribgeapi/src/core/either/either.dart';
import 'package:flutteribgeapi/src/core/provider/provider.dart';
import 'package:flutteribgeapi/src/feature/home/home_page_state.dart';
import 'package:flutteribgeapi/src/model/cidade.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_page_vm.g.dart';

@riverpod
class HomePageVm extends _$HomePageVm {
  @override
  HomePageState build() => HomePageState.initial();

  void setTipoPesquisa(bool tipopesquisa) {
    if (tipopesquisa) {
      state = state.copyWith(pesquisaNome: true, pesquisaRanking: false);
    } else {
      state = state.copyWith(
        pesquisaNome: false,
        pesquisaRanking: true,
      );
    }
  }

  void popDetail() {
    state = state.copyWith(status: HomePageStateStatus.initial);
  }

  void setCidadeINdex(int index) {
    state =
        state.copyWith(cidadeindex: index, status: HomePageStateStatus.initial);
  }

  void setCidade() {
    final cidade = state.listacidades![state.cidadeindex!];
    state = state.copyWith(cidade: cidade, listacidades: []);
  }

  Future<void> buscaCidade(String cidade) async {
    final result = await ref.read(ibgeServiceProvider).buscaCidades(cidade);

    switch (result) {
      case Sucess(value: final cidade):
        {
          if (cidade.length == 1) {
            state = state.copyWith(
                status: HomePageStateStatus.initial, cidade: cidade.first);
          } else {
            state = state.copyWith(
                status: HomePageStateStatus.showmodal,
                listacidades: cidade,
                cidade: null);
          }
        }
        break;
      case Failure(exception: final e):
        {
          state = state.copyWith(status: HomePageStateStatus.error);
        }
    }
  }

  Future<void> pesquisaRankingNomes() async {
    final loanderHandler = AsyncLoaderHandler.start();
    if (state.cidade == null) {
      final result = await ref
          .read(ibgeServiceProvider)
          .rankingPorCidade(state.codigoCidade);
      switch (result) {
        case Sucess(value: final ranking):
          state = state.copyWith(
              status: HomePageStateStatus.loaded, rankingNomes: ranking);
        case Failure(exception: final e):
          state = state.copyWith(
              status: HomePageStateStatus.error, rankingNomes: null);
      }
    } else {
      final result = await ref
          .read(ibgeServiceProvider)
          .rankingPorCidade(state.cidade!.codigo);
      switch (result) {
        case Sucess(value: final ranking):
          state = state.copyWith(
              status: HomePageStateStatus.loaded, rankingNomes: ranking);
        case Failure(exception: final e):
          state = state.copyWith(
              status: HomePageStateStatus.error, rankingNomes: null);
      }
    }

    loanderHandler.close();
  }

  Future<void> pesquisaNomePorcidade(String nome) async {
    final loanderHandler = AsyncLoaderHandler.start();
    if (state.cidade != null) {
      final result = await ref
          .read(ibgeServiceProvider)
          .nomesPorcidade(nome, state.cidade!.codigo);

      switch (result) {
        case Sucess(value: final nomes):
          state = state.copyWith(
              status: HomePageStateStatus.loaded, nomesIbge: nomes);
        case Failure(exception: final e):
          state = state.copyWith(
              status: HomePageStateStatus.error, nomesIbge: null);
      }
    } else {
      final result = await ref
          .read(ibgeServiceProvider)
          .nomesPorcidade(nome, state.codigoCidade);

      switch (result) {
        case Sucess(value: final nomes):
          state = state.copyWith(
              status: HomePageStateStatus.loaded, nomesIbge: nomes);
        case Failure(exception: final e):
          state = state.copyWith(
              status: HomePageStateStatus.error, nomesIbge: null);
      }
    }

    loanderHandler.close();
  }
}
