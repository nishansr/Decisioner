import 'package:firebase_auth/firebase_auth.dart';
import 'package:decisionapp/firebase_options.dart';
import 'package:decisionapp/screens/homescreen.dart';
import 'package:flutter/material.dart';

import 'auth/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DefaultFirebaseOptions();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Welcome()
        // StreamBuilder(
        //   stream: FirebaseAuth.instance.authStateChanges(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       return HomeScreen();
        //     } else {
        //       return Welcome();
        //     }
        //   },
        // ),
        );
  }
}
