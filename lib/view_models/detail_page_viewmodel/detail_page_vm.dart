import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/interfaces/coctail_repository_interface.dart';
import '../../domain/models/coktail_model.dart';
import 'detail_page_states.dart';

class DetailPageVm extends StateNotifier<DetailPageState> {
  final CoktailRepositoryInterface _coktailRepositoryInterface;
  DetailPageVm(this._coktailRepositoryInterface) : super(DetailPageInitial());

  //BORRAR ESTE METODO, SOLO DE MUESTRA/PRUEBA
  void algo(String coktailId) {
    try {
      state = DetailPageLoading();
      Coktail coktail = _coktailRepositoryInterface.getCoktailById(coktailId);
      state = DetailPageLoaded(coktail);
    } catch (e) {
      state = DetailPageError(error: e.toString());
    }
  }
}
