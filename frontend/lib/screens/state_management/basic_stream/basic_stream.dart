// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class StreamBuilder_basic extends StatelessWidget {
  final String judulItem;
  const StreamBuilder_basic({super.key, required this.judulItem});

  Stream<int> a() async* {
    for (int i = 0; i < 10; i++) {
      await Future.delayed(const Duration(seconds: 1));
      yield i;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judulItem),
      ),
      body: Center(
        child: StreamBuilder(
          stream: a(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading...");
            } else {
              return Text("${snapshot.data}");
            }
          },
        ),
      ),
    );
  }
}
