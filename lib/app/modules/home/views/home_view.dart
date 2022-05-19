import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              print("clicked");
              controller.insert();
            },
            child: Text("clicked"),

          ),

          ElevatedButton(
            onPressed: () {
              print("clicked");
              controller.read();
            },
            child: Text("clicked"),

          ),
        ],
      ),
    );
  }
}
