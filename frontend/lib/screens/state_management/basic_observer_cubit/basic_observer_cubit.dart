// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit({this.initialData = 0}) : super(initialData);

  int initialData;

  int? current;
  int? next;

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
    current = change.currentState;
    next = change.nextState;
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print(error);
  }
}

class Observer_cubit extends StatefulWidget {
  final String title;
  const Observer_cubit({super.key, required this.title});

  @override
  State<Observer_cubit> createState() => _Observer_cubitState();
}

class _Observer_cubitState extends State<Observer_cubit> {
  CounterCubit mycounter = CounterCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Showing Observer in Cubit"),
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
                  return Column(
                    children: [
                      Text(
                        "${snapshot.data}",
                        style: TextStyle(fontSize: 50),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "current state : ${mycounter.current}",
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              "next state : ${mycounter.next}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
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
