import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/interfaces/coctail_repository_interface.dart';
import 'home_page_states.dart';

class HomePageVm extends StateNotifier<HomePageState> {
  final CoktailRepositoryInterface _coktailRepositoryInterface;
  HomePageVm(this._coktailRepositoryInterface) : super(HomePageInitial());

  //BORRAR ESTE METODO, SOLO DE MUESTRA/PRUEBA
  void algo() {
    try {
      state = HomePageLoading();
      var xxx = _coktailRepositoryInterface.getAllCoktails();
      state = HomePageLoaded(xxx);
    } catch (e) {
      state = HomePageError(error: e.toString());
    }
  }
}
