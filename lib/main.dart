// ignore_for_file: must_be_immutable

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_bin/const/const.dart';
import 'package:green_bin/const/end_points.dart';
import 'package:green_bin/cubit/cubit.dart';
import 'package:green_bin/screens/login/login_screen.dart';
import 'package:green_bin/screens/on_bored_screen.dart';
import 'package:green_bin/shared/cache_helper.dart';
import 'package:green_bin/shared/dio_helper.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await CacheHellper.init();

  DioHelper.init();
  firebasetoken = await FirebaseMessaging.instance.getToken();

  apiToken = CacheHellper.getData(key: 'apiToken');
  var onboard = CacheHellper.getData(key: 'onbordeing');

  Widget widget;

  if (onboard != null) {
    widget = const LoginScreen();
  } else {
    widget = OnBoredScreen();
  }

  runApp(
    MyApp(
      startWidget: widget,
    ),
  );
}

class MyApp extends StatelessWidget {
  Widget startWidget;

  MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()..getNotif()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          accentColor: const Color(0xFF00B761),
          primarySwatch: Colors.green,
          primaryColor: const Color(0xFF00B761),
          iconTheme: const IconThemeData(
            color: Colors.black,
            opacity: 10,
            size: 25,
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: deafaultColor,
            elevation: 50,
          ),
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
            headline2: TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
            bodyText1: TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
            bodyText2: TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        home: SplashScreen(
          startWidget: startWidget,
        ),
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  Widget startWidget;

  SplashScreen({Key? key, required this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: const Center(
        child: Image(
            image: AssetImage(
          'assets/images/greenpin.png',
        )),
      ),
      duration: 3000,
      backgroundColor: deafaultColor!,
      splashTransition: SplashTransition.sizeTransition,
      pageTransitionType: PageTransitionType.topToBottom,
      animationDuration: const Duration(seconds: 1),
      nextScreen: startWidget,
    );
  }
}
