import '../../domain/models/coktail_model.dart';

abstract class CoktailRepositoryInterface {
  List<dynamic> getAllCoktails();
  Coktail getCoktailById(String coktailId);
}
