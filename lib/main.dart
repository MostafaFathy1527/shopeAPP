import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shope/view/auth/login_screen.dart';
import 'package:shope/view/controlview.dart';

import 'core/view_model/control_view_model.dart';
import 'core/view_model/home_view_model.dart';
import 'helper/dinding.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb)
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyAjsLChkq1ykaJ8LvD6Bvqet0_LbO0DWkI",
        authDomain: "shope-2c566.firebaseapp.com",
        projectId: "shope-2c566",
        storageBucket: "shope-2c566.appspot.com",
        messagingSenderId: "477686680239",
        appId: "1:477686680239:web:dc7d008ccdedbe2b8f625a",
        measurementId: "G-89LYEE4GD2",
      ),
    );
  else
    await Firebase.initializeApp();
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
  final controlViewModel = Get.put(ControlViewModel());
  final homeViewModel = Get.put(HomeViewModel()); // Update this line
  final CartViewModel = Get.put(HomeViewModel()); // Update this line

   MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: Binding(),
      title: 'Flutter Demo',
      home: Scaffold(
        body: ControlView(),
    ),
    );
  }
}
