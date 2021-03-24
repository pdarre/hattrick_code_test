import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/routes/routes.dart';
import 'domain/providers_references/providers.dart';
import 'view/home_page/home_page.dart';

void main() {
  runApp(
    ProviderScope(
      // child: MyApp(),
      child: MyCupertinoApp(),
    ),
  );
}

class MyCupertinoApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final themeSwitcher = watch(themeSwitcherProvider);
    return Theme(
      data: themeSwitcher.isDark
          ? ThemeData.dark().copyWith(
              primaryColor: Color.fromARGB(255, 75, 113, 142),
              iconTheme: IconThemeData(color: Colors.white70),
              textTheme: TextTheme(
                headline5: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[400]),
                bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
                bodyText1: TextStyle(
                    fontSize: 16.0, fontFamily: 'Hind', color: Colors.white70),
              ),
            )
          : ThemeData.light().copyWith(
              primaryColor: Color.fromARGB(255, 78, 168, 209),
              iconTheme: IconThemeData(color: Colors.black87),
              textTheme: TextTheme(
                headline5: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800]),
                bodyText2: TextStyle(
                    fontSize: 14.0, fontFamily: 'Hind', color: Colors.black),
                bodyText1: TextStyle(
                    fontSize: 16.0, fontFamily: 'Hind', color: Colors.black87),
              ),
            ),
      child: CupertinoApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        routes: MyRoutes.routes,
        initialRoute: '/home-page',
      ),
    );
  }
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final themeSwitcher = watch(themeSwitcherProvider);
    return MaterialApp(
      theme: themeSwitcher.isDark
          ? ThemeData.dark().copyWith(
              primaryColor: Color.fromARGB(255, 75, 113, 142),
              iconTheme: IconThemeData(color: Colors.white70),
              textTheme: TextTheme(
                headline5: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[400]),
                bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
                bodyText1: TextStyle(
                    fontSize: 16.0, fontFamily: 'Hind', color: Colors.white70),
              ),
            )
          : ThemeData.light().copyWith(
              primaryColor: Color.fromARGB(255, 78, 168, 209),
              iconTheme: IconThemeData(color: Colors.black87),
              textTheme: TextTheme(
                headline5: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800]),
                bodyText2: TextStyle(
                    fontSize: 14.0, fontFamily: 'Hind', color: Colors.black),
                bodyText1: TextStyle(
                    fontSize: 16.0, fontFamily: 'Hind', color: Colors.black87),
              ),
            ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: MyRoutes.routes,
      initialRoute: '/home-page',
    );
  }
}
