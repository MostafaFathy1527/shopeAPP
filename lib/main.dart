import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shope/view/auth/login_screen.dart';

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
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return  GetMaterialApp(
      initialBinding: Binding(),
      title: 'Flutter Demo',
      home: Scaffold(
        body: LoginScreen(),
    ),
    );
  }
}
