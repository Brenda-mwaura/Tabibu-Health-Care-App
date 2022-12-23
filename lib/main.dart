import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tabibu/configs/routes.dart';
import 'package:tabibu/providers/auth_provider.dart';
import 'package:tabibu/providers/geolocation_provider.dart.dart';
import 'package:tabibu/providers/google_signin_provider.dart';
import 'package:tabibu/providers/profile_provider.dart';
import 'package:tabibu/services/navigation_service.dart';

// initialize firebase
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // MaterialColor priSwatch = MaterialColor(
  //   const Color.fromARGB(255, 226, 35, 26).value,
  //   const <int, Color>{
  //     50: Color.fromARGB(255, 226, 35, 26),
  //   },
  // );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: geolocationProvider),
        ChangeNotifierProvider.value(value: googleSignInProvider),
        ChangeNotifierProvider.value(value: authProvider),
        ChangeNotifierProvider.value(value: profileProvider),
      ],
      child: MaterialApp(
        title: "Tabibu Health",
        onGenerateTitle: (context) => "Tabibu",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          focusColor: Colors.black,
          scaffoldBackgroundColor: Colors.grey[100],
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: "/",
        onGenerateRoute: RouteGenerator.generateRoute,
        navigatorKey: Navigate.instance.navigationKey,
      ),
    );
  }
}
