import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifts_app/model/carsModel.dart';
import 'package:lifts_app/pages/LoginScreen.dart';
import 'package:lifts_app/pages/fogortPasswordScreen.dart';
import 'package:lifts_app/pages/homeScreen.dart';
import 'package:lifts_app/pages/landingScreen.dart';
import 'package:lifts_app/pages/liftDetailsScreen.dart';
import 'package:lifts_app/pages/loadingScreen.dart';
import 'package:lifts_app/pages/signUpScreen.dart';
import 'package:lifts_app/views/resetPasswordForm.dart';

import 'package:provider/provider.dart';
import 'package:lifts_app/model/lifts_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'model/lift.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LiftsViewModel(),
        ),
        ChangeNotifierProvider(create: (context) => CarsModel())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  String getUserState() {
    String route = '/';
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      print(user?.email);
      if (user != null) {
        route = '/homeScreen';
      }
    });
    print(route);
    return route;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Lifts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: ChangeNotifierProvider(
      //     create: (context) => LiftsViewModel(),
      //     child: const HomeScreen(),
      // ),
      initialRoute: getUserState(),
      routes: {
        '/': (context) => const LandingScreen(),
        '/login': (context) => const LoginScreen(),
        '/signUp': (context) => const SignUpScreen(),
        '/resetPassword': (context) => const ForgotPasswordScreen(),
        '/homeScreen': (context) => const HomeScreen(),
        '/loadingScreen':(context) => const LoadingScreen(),
        '/liftDetails':(context)=> const LiftDetailsScreen(),
      },
    );
  }
}
