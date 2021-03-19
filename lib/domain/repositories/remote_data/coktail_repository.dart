import '../../interfaces/coctail_repository_interface.dart';
import '../../models/coktail_model.dart';

class CoktailRepository implements CoktailRepositoryInterface {
  @override
  List<dynamic> getAllCoktails() {
    //conecta con la base de datos remota y retorna la consulta luego de parsearla con FromJson
    return [];
  }

  @override
  Coktail getCoktailById(String coktailId) {
    //conecta con la base de datos remota y retorna la consulta luego de parsearla con FromJson
    return Coktail();
  }
}
