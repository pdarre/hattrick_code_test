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
      backgroundColor: Colors.blue[100],
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

class BuildDetailPageError extends StatelessWidget {
  final String error;
  const BuildDetailPageError({this.error});
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class BuildDetailPageInitial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text(
          '${drink.strDrink}',
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
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
                            FadeIn(
                              delay: Duration(milliseconds: 200),
                              child: const Text(
                                'Ingredients',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: FadeIn(
                                delay: Duration(milliseconds: 300),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getTextWidgets(drink.ingredientes),
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
                          child: const Text(
                            'How to prepare',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                            overflow: TextOverflow.ellipsis,
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

Widget getTextWidgets(List<String> strings) {
  List<Widget> list = [];
  for (var i = 0; i < strings.length; i++) {
    list.add(new Text(strings[i]));
  }
  return new Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: list,
  );
}
