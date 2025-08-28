import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:test_tik_tok_cat/Home/HomeScreen.dart';
class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SplashScreen();

}
class _SplashScreen extends State<SplashScreen>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    // Puedes ajustar la duración según lo que dure tu animación
    await Future.delayed(const Duration(milliseconds: 4000), () {}); // 4 segundos
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFF0C0000),
          body: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFF0C0000),
              image: DecorationImage(
                image: AssetImage('assets/Lineas-sombras-login 1.png'),
                fit: BoxFit.cover,
              ),
            ),
              child: Lottie.asset(
                'assets/animation_json/cat_splash_animation.json', // Asegúrate de que la ruta sea correcta
                width: 250,
                height: 250,
                fit: BoxFit.fill,
              )
          ),
        )
    );
  }
  
}