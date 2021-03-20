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
              physics: BouncingScrollPhysics(),
              itemCount: drinkList.length,
              itemExtent: 60.0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${drinkList[index].strDrink}'),
                  subtitle: Text('${drinkList[index].idDrink}'),
                  leading: FadeInImage(
                    placeholder: AssetImage('assets/images/loading.gif'),
                    image: NetworkImage('${drinkList[index].strDrinkThumb}'),
                    fit: BoxFit.fill,
                  ),
                  tileColor: Colors.white,
                  trailing: IconButton(
                    icon: Icon(Icons.chevron_right),
                    onPressed: () {
                      context
                          .read(detailPageProvider)
                          .getDrinkById(drinkList[index].idDrink);
                      Navigator.of(context).pushNamed('/detail-page');
                    },
                  ),
                );
                // return FadeInRight(
                //   delay: Duration(milliseconds: 50 * index),
                //   child: BuildDrinkCard(drink: drinkList[index]),
                // );
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(15),
          elevation: 5,
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
          )),
    );
  }
}
