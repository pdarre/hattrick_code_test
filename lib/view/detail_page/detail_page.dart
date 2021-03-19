import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
        centerTitle: true,
        actions: [
          Container(
            padding: const EdgeInsets.all(10),
            width: 80,
            child: Image.asset('assets/images/logo_white.png'),
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: const Text('Detail Page'),
        ),
      ),
    );
  }
}
