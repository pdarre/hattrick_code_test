import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/drink_model.dart';
import '../../domain/providers_references/future_providers.dart';

class DetailPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final String drinkId = ModalRoute.of(context).settings.arguments;
    final getDrinkById = watch(getDrinkByIdFutureProvider(drinkId));
    return getDrinkById.when(
      loading: () => BuildLoading(),
      error: (Object error, stack) => BuildError(message: error.toString()),
      data: (drink) => BuildDrinkDetail(drink: drink),
    );
  }
}

class BuildLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

class BuildError extends StatelessWidget {
  final String message;
  const BuildError({this.message});
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class BuildDrinkDetail extends StatelessWidget {
  final Drinks drink;
  const BuildDrinkDetail({this.drink});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text(
          '${drink.strDrink}',
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    child: FadeInImage(
                      placeholder: AssetImage('assets/images/loading.gif'),
                      image: NetworkImage('${drink.strDrinkThumb}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ingredients',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${drink.strIngredient1}'),
                                Text('${drink.strIngredient2}'),
                                Text('${drink.strIngredient3}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        'How to prepare',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text('${drink.strInstructions}'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
