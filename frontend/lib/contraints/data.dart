import 'package:flutter/material.dart';
import 'package:ylupi/screens/main_screens/networking_screen.dart';
import 'package:ylupi/screens/networking_https/crud_api_2/read_data.dart';
import 'package:ylupi/screens/main_screens/state_management_screen.dart';
import 'package:ylupi/screens/networking_https/crud_api_1/networking_api_local.dart';
import 'package:ylupi/screens/networking_https/firebase_stream/firebase_stream.dart';
import 'package:ylupi/screens/networking_https/networking_https.dart';
import 'package:ylupi/screens/state_management/basic_cubit/basic_cubit.dart';
import 'package:ylupi/screens/state_management/basic_stream/basic_stream.dart';
import 'package:ylupi/screens/state_management/multi_provider/multi_provider.dart';

class dataMenu {
  static List<Map<String, dynamic>> listData = [
    {
      "judul_item": "State Managament",
      "link_item": StateManagementScreen(
        judulItem: 'State Managament',
      ),
    },
    {
      "judul_item": "Networking HTTPS",
      "link_item": NetworkingScreen(
        judulItem: 'Networking HTTPS',
      ),
    },
  ];

  static List<Map<String, dynamic>> gridDataNetworking = [
    {
      "judul_item": "Dummy Data Online API",
      "warna_item": Colors.purpleAccent,
      "link_item": NetworkingHttps(),
    },
    {
      "judul_item": "CRUD Local API Simple",
      "warna_item": Colors.blueAccent,
      "link_item": NetworkingApiLocal(),
    },
    {
      "judul_item": "CRUD Local API",
      "warna_item": Colors.pinkAccent,
      "link_item": CrudApi(),
    },
    {
      "judul_item": "CRUD Firebase",
      "warna_item": Colors.tealAccent,
      "link_item": FirebaseStream(),
    },
  ];

  static List<Map<String, dynamic>> gridData = [
    {
      "judul_item": "Multi Provider",
      "warna_item": Colors.blueAccent,
      "link_item": MultiProviderExample(
        judulItem: 'Multi Provider',
      ),
    },
    {
      "judul_item": "Basic Stream Builder",
      "warna_item": Colors.redAccent,
      "link_item": StreamBuilder_basic(
        judulItem: 'Basic Stream Builder',
      ),
    },
    {
      "judul_item": "Basic Cubit",
      "warna_item": Colors.orangeAccent,
      "link_item": Cubit_basic(
        judulItem: "Basic Cubit",
      )
    },
  ];
}
