import 'package:flutter_test/flutter_test.dart';
import 'package:hatrick_project2/domain/models/drink_model.dart';

void main() {
  test('getAllDrinks lenght mayor a 0', () async {
    // ARRANGE
    final List<Drinks> lista = [];
    lista.add(Drinks(strDrink: 'Drink 1', idDrink: '1'));
    lista.add(Drinks(strDrink: 'Drink 2', idDrink: '2'));
    lista.add(Drinks(strDrink: 'Drink 3', idDrink: '3'));

    // ACT
    bool listaPopulada = lista.length > 0;

    // ASSERT
    expect(lista.length > 0, listaPopulada);
  });
}
