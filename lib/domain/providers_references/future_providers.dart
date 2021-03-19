// aca van los futureProviders

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatrick_project2/domain/models/drink_model.dart';
import 'package:hatrick_project2/domain/providers_references/providers.dart';

final getDrinkByIdFutureProvider =
    FutureProvider.autoDispose.family<Drinks, String>((ref, drinkId) {
  return ref.watch(coktailRepositoryInterface).getCoktailById(drinkId);
});

final getAllDrinksFutureProvider = FutureProvider<List<Drinks>>((ref) {
  return ref.watch(coktailRepositoryInterface).getAllCoktails();
});
