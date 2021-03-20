import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/drink_model.dart';
import '../../domain/providers_references/future_providers.dart';
import '../../domain/providers_references/providers.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final getAllDrinks = watch(getAllDrinksFutureProvider);
    return getAllDrinks.when(
      loading: () => BuildHomePageLoading(),
      error: (error, stack) => BuildHomePageError(error: error.toString()),
      data: (data) => BuildHomePageLoaded(drinkList: data),
    );
  }
}

class BuildHomePageLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 78, 168, 209),
      body: Container(
        child: Center(
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class BuildHomePageError extends StatelessWidget {
  final String error;
  const BuildHomePageError({this.error});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 78, 168, 209),
      body: Container(
        child: Center(
          child: Text('$error'),
        ),
      ),
    );
  }
}

class BuildHomePageLoaded extends ConsumerWidget {
  final List<Drinks> drinkList;
  const BuildHomePageLoaded({this.drinkList});
  @override
  Widget build(BuildContext context, watch) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 78, 168, 209),
      body: (drinkList != null)
          ? ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: drinkList.length,
              itemBuilder: (context, index) {
                return BuildDrinkCard(drink: drinkList[index]);
              },
            )
          : Container(
              child: const Text('Error, try again..'),
            ),
    );
  }
}

class BuildDrinkCard extends StatelessWidget {
  final Drinks drink;
  const BuildDrinkCard({this.drink});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read(detailPageProvider).getDrinkById(drink.idDrink);
        Navigator.of(context).pushNamed('/detail-page');
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        margin: EdgeInsets.all(15),
        elevation: 5,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.only(left: 30),
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      '${drink.strDrink}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.black54),
                    ),
                    Text('${drink.idDrink}'),
                    // getTextWidgets(drink.ingredients),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  SizedBox(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: FadeInImage(
                        placeholder: AssetImage('assets/images/loading.gif'),
                        image: NetworkImage('${drink.strDrinkThumb}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget getTextWidgets(List<String> ingredients) {
  List<Widget> list = [];
  for (var i = 0; i < ingredients.length; i++) {
    list.add(Text('${ingredients[i]}'));
  }
  return new Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: list,
  );
}
