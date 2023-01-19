// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:ylupi/contraints/data.dart';
import 'package:ylupi/widgets/content_item_grid.dart';

class StateManagementScreen extends StatelessWidget {
  final String judulItem;
  const StateManagementScreen({Key? key, required this.judulItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judulItem),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              contentGrid(dataMenu: dataMenu.gridData),
            ],
          ),
        ),
      ),
    );
  }
}
