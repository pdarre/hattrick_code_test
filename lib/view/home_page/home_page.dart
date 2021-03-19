import 'package:animate_do/animate_do.dart';
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
      backgroundColor: Colors.blue[100],
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
      backgroundColor: Colors.blue[100],
      body: Container(
        child: Center(
          child: Text('$error'),
        ),
      ),
    );
  }
}

class BuildHomePageLoaded extends StatelessWidget {
  final List<Drinks> drinkList;
  const BuildHomePageLoaded({this.drinkList});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: (drinkList != null)
          ? ListView.builder(
              itemCount: drinkList.length,
              itemBuilder: (context, index) {
                return FadeInRight(
                  delay: Duration(milliseconds: 50 * index),
                  child: BuildDrinkCard(drink: drinkList[index]),
                );
              },
            )
          : Container(
              child: const Text('Error'),
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(15),
          elevation: 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(left: 30),
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${drink.strDrink}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text('${drink.idDrink}'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: FadeInImage(
                            placeholder:
                                AssetImage('assets/images/loading.gif'),
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
          )),
    );
  }
}
