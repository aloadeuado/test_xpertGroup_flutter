import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Data/Services/CatApiService.dart';
import 'Presentation/Providers/HomeProvider.dart';
import 'Presentation/Screens/Splash/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // El provider del Home necesita el servicio de la API
        ChangeNotifierProvider(
          create: (_) => HomeProvider(CatApiService()),
        ),
      ],
      child: MaterialApp(
        title: 'Cat App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF0C0000), // Color base
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF0C0000),
            elevation: 0,
          ),
          fontFamily: 'Poppins', // Considera añadir una fuente bonita
        ),
        home: SplashScreen(),
      ),
    );
  }
}