import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/drink_model.dart';
import '../../domain/providers_references/providers.dart';
import '../../view_models/detail_page_viewmodel/detail_page_states.dart';

class DetailPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final detailProvider = watch(detailPageProvider.state);

    if (detailProvider is DetailPageLoading) {
      return BuildDetailPageLoading();
    } else if (detailProvider is DetailPageError) {
      return BuildDetailPageError(error: detailProvider.error);
    } else if (detailProvider is DetailPageLoaded) {
      return BuildDetailPageLoaded(drink: detailProvider.drink);
    } else {
      return BuildDetailPageInitial();
    }
  }
}

class BuildDetailPageLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 78, 168, 209),
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

class BuildDetailPageError extends StatelessWidget {
  final String error;
  const BuildDetailPageError({this.error});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 78, 168, 209),
      body: Center(
        child: Text(error),
      ),
    );
  }
}

class BuildDetailPageInitial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 78, 168, 209),
      body: Center(
        child: const Text('Iniating...'),
      ),
    );
  }
}

class BuildDetailPageLoaded extends StatelessWidget {
  final Drinks drink;
  const BuildDetailPageLoaded({this.drink});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 78, 168, 209),
      appBar: AppBar(
        title: Text(
          '${drink.strDrink}',
        ),
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Center(
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: FadeInImage(
                            placeholder:
                                AssetImage('assets/images/loading.gif'),
                            image: NetworkImage('${drink.strDrinkThumb}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeIn(
                              delay: Duration(milliseconds: 200),
                              child: Consumer(
                                builder: (_, watch, __) {
                                  final themeChanger =
                                      watch(themeSwitcherProvider);
                                  return themeChanger.isDark
                                      ? Text('Ingredients',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1)
                                      : Text('Ingredients',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1);
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: FadeIn(
                                delay: Duration(milliseconds: 300),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getTextWidgets(
                                        drink.ingredients, drink.measures),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        FadeIn(
                          delay: Duration(milliseconds: 500),
                          child: Consumer(
                            builder: (context, watch, child) {
                              final themeChanger = watch(themeSwitcherProvider);
                              return themeChanger.isDark
                                  ? Text('How to prepare',
                                      style:
                                          Theme.of(context).textTheme.bodyText1)
                                  : Text('Ingredients',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1);
                            },
                          ),
                        ),
                      ],
                    ),
                    FadeIn(
                      delay: Duration(milliseconds: 600),
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Text('${drink.strInstructions}'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget getTextWidgets(List<String> ingredients, List<String> measures) {
  List<Widget> list = [];
  for (var i = 0; i < ingredients.length; i++) {
    list.add(Text('${measures[i]} - ${ingredients[i]}'));
  }
  return new Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: list,
  );
}
