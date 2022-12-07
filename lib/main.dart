import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tabibu/configs/routes.dart';
import 'package:tabibu/providers/permissions.dart';
import 'package:tabibu/services/navigation_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
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
        ChangeNotifierProvider.value(value: permissionProvider),
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
