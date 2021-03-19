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
  Future<Drink> getCoktailById(String coktailId) async {
    try {
      Response response = await Dio().get(
          'https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=16108');
      Drink drink = response.data.map((item) => Drink.fromJson(item.data()));
      print(drink);
      return drink;
    } catch (e) {
      throw Error();
    }
  }
}
