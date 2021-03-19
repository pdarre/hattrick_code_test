import 'package:dio/dio.dart';

import '../../interfaces/coctail_repository_interface.dart';
import '../../models/drink_model.dart';

class CoktailRepository implements CoktailRepositoryInterface {
  @override
  Future<List<Drinks>> getAllCoktails() async {
    try {
      Response response = await Dio().get(
          'https://www.thecocktaildb.com/api/json/v1/1/filter.php?g=Cocktail_glass');
      List<Drinks> drinks = Drink.fromJson(response.data).drinks;
      return drinks;
    } catch (e) {
      print(e.toString());
      throw Error();
    }
  }

  @override
  Future<Drinks> getCoktailById(String drinkId) async {
    try {
      Response response = await Dio().get(
          'https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=$drinkId');
      List<Drinks> drinks = Drink.fromJson(response.data).drinks;
      return drinks[0];
    } catch (e) {
      throw Error();
    }
  }
}
