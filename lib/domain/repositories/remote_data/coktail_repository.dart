import 'package:dio/dio.dart';
import 'package:hatrick_project2/core/constants/constants.dart';

import '../../interfaces/coctail_repository_interface.dart';
import '../../models/drink_model.dart';

class CoktailRepository implements CoktailRepositoryInterface {
  @override
  Future<List<Drinks>> getAllCoktails() async {
    try {
      Response response = await Dio().get(Constants.baseUrl +
          Constants.apiKey +
          '/filter.php?g=Cocktail_glass');
      List<Drinks> drinks = Drink.fromJson(response.data).drinks;
      return drinks;
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<Drinks> getCoktailById(String drinkId) async {
    try {
      Response response = await Dio()
          .get(Constants.baseUrl + Constants.apiKey + '/lookup.php?i=$drinkId');
      List<Drinks> drinks = Drink.fromJson(response.data).drinks;
      return drinks[0];
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
