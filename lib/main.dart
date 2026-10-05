import 'package:flutter/material.dart';
import 'package:football/binding/controller_binding.dart';
import 'package:football/routes/app_pages.dart';
import 'package:football/view/home_view.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      initialBinding: ControllerBinding(),
      getPages: AppPages.pages,
      home: HomeView(),
    );
  }
}
