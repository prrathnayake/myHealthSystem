import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_health/components/bottombar.dart';
import 'package:e_health/screens/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eHealth Application',
      home: FutureBuilder(
        future: checkConnectivity(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != ConnectivityResult.mobile &&
                snapshot.data != ConnectivityResult.wifi) {
              return const NoConnection();
            } else {
              return StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return const BottomBar();
                    } else {
                      return const WelcomeScreen();
                    }
                  });
            }
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}

Future<ConnectivityResult> checkConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  return connectivityResult;
}

class NoConnection extends StatelessWidget {
  const NoConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("No Network Connection"),
            const SizedBox(height: 10),
            const Text(
                "Please connect to a mobile or WiFi network and restart application."),
            const SizedBox(height: 10),
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                checkConnectivity();
              },
            )
          ],
        ),
      ),
    );
  }
}
