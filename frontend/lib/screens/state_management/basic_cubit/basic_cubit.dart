// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit({
    this.initialData = 0,
  }) : super(initialData);

  int initialData;

  void tambahData() {
    emit(state + 1);
  }

  void kurangData() {
    emit(state - 1);
  }

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    print(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print(error);
  }
}

class Cubit_basic extends StatelessWidget {
  final String judulItem;
  Cubit_basic({super.key, required this.judulItem});

  CounterCubit mycounter = CounterCubit(
    initialData: 22,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(judulItem),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
                initialData: mycounter.initialData,
                stream: mycounter.stream,
                builder: (context, snapshot) {
                  // if (snapshot.connectionState == ConnectionState.waiting) {
                  //   return Text(
                  //     "Loading ...",
                  //     style: TextStyle(fontSize: 50),
                  //   );
                  // } else {
                  return Text(
                    "${snapshot.data}",
                    style: TextStyle(fontSize: 50),
                  );
                  // }
                }),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    mycounter.kurangData();
                  },
                  icon: const Icon(
                    Icons.remove,
                    size: 20.0,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    mycounter.tambahData();
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 20.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
